local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Constants
local TRACK_MODEL_ID = "rbxassetid://77274282170734"
local MINECART_MODEL_ID = "rbxassetid://134508398478924"
local ANIMATIONS = {
    SITTING = "rbxassetid://89511002780891",
    TURN_RIGHT = "rbxassetid://133886478211062",
    TURN_LEFT = "rbxassetid://74584476588827",
    MOVE_STRAIGHT = "rbxassetid://132863810915492"
}

local TRACK_DIMENSIONS = Vector3.new(6.258, 0.194, 15.869)
local TRACKS_FOLDER = workspace:FindFirstChild("Tracks") or Instance.new("Folder")
TRACKS_FOLDER.Name = "Tracks"
TRACKS_FOLDER.Parent = workspace

local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")

-- Game Config
local CONFIG = {
    STRAIGHT_BEFORE_FORK = 8,
    MIN_EXIT_DISTANCE = TRACK_DIMENSIONS.Z * 4,
    FORK_ANGLES = {
        MIN = 20,
        MAX = 35
    },
    SPEEDS = {
        NORMAL = 1,
        TURN = 2
    }
}

-- Game State
local GameState = {
    minecart = nil,
    currentTrack = nil,
    trackCount = 0,
    playerInput = nil,
    isMoving = false,
    animations = {}
}

-- Utility Functions
local function getExitDistance(position)
    local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(LatestRoom.Value))
    if not currentRoom then return math.huge end
    
    local exit = currentRoom:FindFirstChild("RoomExit")
    if not exit then return math.huge end
    
    return (position - exit.Position).Magnitude
end

local function loadTrackModel()
    local success, model = pcall(function()
        return game:GetObjects(TRACK_MODEL_ID)[1]
    end)
    
    if not success or not model then
        warn("Failed to load track model")
        return nil
    end
    
    return model
end

local function createTrack(startPos, endPos, isCurved)
    local track = loadTrackModel()
    if not track then return nil end
    
    local direction = (endPos - startPos).Unit
    local trackCFrame = CFrame.lookAt(startPos, endPos)
    
    if isCurved then
        for _, part in pairs(track:GetChildren()) do
            if part.Name:lower():find("curve") then
                track.PrimaryPart = part
                break
            end
        end
    end
    
    track:SetPrimaryPartCFrame(trackCFrame)
    track.Parent = TRACKS_FOLDER
    
    return track
end

local function createFork(position, direction)
    local mainTrack = createTrack(position, position + direction * TRACK_DIMENSIONS.Z, false)
    if not mainTrack then return nil end
    
    mainTrack.Name = "MainTrack"
    mainTrack:SetAttribute("IsFork", true)
    
    local leftAngle = math.rad(math.random(CONFIG.FORK_ANGLES.MIN, CONFIG.FORK_ANGLES.MAX))
    local rightAngle = math.rad(-math.random(CONFIG.FORK_ANGLES.MIN, CONFIG.FORK_ANGLES.MAX))
    
    local leftDir = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), leftAngle) * direction
    local rightDir = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), rightAngle) * direction
    
    local forkStart = position + direction * TRACK_DIMENSIONS.Z
    
    local leftTrack = createTrack(forkStart, forkStart + leftDir * TRACK_DIMENSIONS.Z, true)
    local rightTrack = createTrack(forkStart, forkStart + rightDir * TRACK_DIMENSIONS.Z, true)
    
    if leftTrack and rightTrack then
        leftTrack.Name = "LeftTrack"
        rightTrack.Name = "RightTrack"

        local tracks = {mainTrack, leftTrack, rightTrack}
        local shortestDist = math.huge
        local correctTrack = nil
        
        for _, track in ipairs(tracks) do
            local dist = getExitDistance(track.PrimaryPart.Position)
            if dist < shortestDist then
                shortestDist = dist
                correctTrack = track
            end
        end
        
        -- Marcar trilho correto
        for _, track in ipairs(tracks) do
            track:SetAttribute("IsCorrect", track == correctTrack)
        end
    end
    
    return mainTrack
end

local function generatePath()
    local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(LatestRoom.Value))
    if not currentRoom then return nil end
    
    local entrance = currentRoom:FindFirstChild("RoomEntrance")
    local exit = currentRoom:FindFirstChild("RoomExit")
    if not (entrance and exit) then return nil end
    
    local path = PathfindingService:CreatePath()
    local success = pcall(function()
        path:ComputeAsync(entrance.Position, exit.Position)
    end)
    
    if not success or path.Status ~= Enum.PathStatus.Success then
        return nil
    end
    
    return path:GetWaypoints()
end

-- Track Generation and Management
local function generateTracks()
    TRACKS_FOLDER:ClearAllChildren()
    GameState.trackCount = 0
    
    local waypoints = generatePath()
    if not waypoints then return end
    
    local lastTrack = nil
    local lastPos = waypoints[1].Position
    
    for i = 2, #waypoints do
        local currentPos = lastPos
        local nextPos = waypoints[i].Position
        local distToExit = getExitDistance(currentPos)
        
        -- Decidir se cria bifurcação ou trilho reto
        if GameState.trackCount >= CONFIG.STRAIGHT_BEFORE_FORK and distToExit > CONFIG.MIN_EXIT_DISTANCE then
            local direction = (nextPos - currentPos).Unit
            lastTrack = createFork(currentPos, direction)
            GameState.trackCount = 0
        else
            lastTrack = createTrack(currentPos, nextPos, false)
            GameState.trackCount = GameState.trackCount + 1
        end
        
        if lastTrack then
            lastTrack:SetAttribute("TrackNumber", i)
            lastPos = lastTrack.PrimaryPart.Position + (nextPos - currentPos).Unit * TRACK_DIMENSIONS.Z
        end
    end
end

-- Minecart Controls
local function setupMinecartControls()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.A then
            GameState.playerInput = "Left"
            if GameState.animations.turnLeft then
                GameState.animations.turnLeft:Play()
            end
        elseif input.KeyCode == Enum.KeyCode.D then
            GameState.playerInput = "Right"
            if GameState.animations.turnRight then
                GameState.animations.turnRight:Play()
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
            GameState.playerInput = nil
            if GameState.animations.moveStraight then
                GameState.animations.moveStraight:Play()
            end
        end
    end)
end

local function getNextTrack(currentTrack)
    if not currentTrack then return nil end
    
    if currentTrack:GetAttribute("IsFork") then
        local trackName = 
            GameState.playerInput == "Left" and "LeftTrack" or
            GameState.playerInput == "Right" and "RightTrack" or
            "MainTrack"
        
        return TRACKS_FOLDER:FindFirstChild(trackName)
    else
        local currentNumber = currentTrack:GetAttribute("TrackNumber")
        for _, track in ipairs(TRACKS_FOLDER:GetChildren()) do
            if track:GetAttribute("TrackNumber") == currentNumber + 1 then
                return track
            end
        end
    end
    return nil
end

local function moveMinecart(nextTrack)
    if not (GameState.minecart and nextTrack) then return end
    
    local tweenInfo = TweenInfo.new(
        nextTrack:GetAttribute("IsFork") and CONFIG.SPEEDS.TURN or CONFIG.SPEEDS.NORMAL,
        Enum.EasingStyle.Linear
    )
    
    local tween = TweenService:Create(GameState.minecart.PrimaryPart, tweenInfo, {
        CFrame = nextTrack.PrimaryPart.CFrame
    })
    
    GameState.isMoving = true
    tween:Play()
    
    tween.Completed:Connect(function()
        GameState.isMoving = false
        GameState.currentTrack = nextTrack
        
        if not nextTrack:GetAttribute("IsCorrect") then
            local player = Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
        end
    end)
end

-- Main Game Loop
local function startMinecartRide()
    GameState.minecart = game:GetObjects(MINECART_MODEL_ID)[1]
    if not GameState.minecart then return end
    
    GameState.minecart.Parent = workspace

    local firstTrack = TRACKS_FOLDER:FindFirstChild("MainTrack") or TRACKS_FOLDER:GetChildren()[1]
    if firstTrack then
        GameState.minecart:SetPrimaryPartCFrame(firstTrack.PrimaryPart.CFrame)
        GameState.currentTrack = firstTrack

        local player = Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		    local root = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then	
                humanoid.PlatformStand = true
				
                local playerCFrame = GameState.minecart:FindFirstChild("PlayerCFrame")
                if playerCFrame then
				    root.CFrame = playerCFrame.CFrame
					wait(0.2)
                    local playerWeld = Instance.new("Weld")
                    playerWeld.Name = "PlayerWeld"
                    playerWeld.Part0 = root
                    playerWeld.Part1 = playerCFrame
                    playerWeld.C0 = CFrame.new(0, 0, 0)
                    playerWeld.Parent = root
                end
            end
        end
    end
    
    setupMinecartControls()

    while true do
        if not GameState.isMoving then
            local player = Players.LocalPlayer
            if player.Character and 
               player.Character:FindFirstChild("HumanoidRootPart") and 
               player.Character.HumanoidRootPart:FindFirstChild("PlayerWeld") then
                
                local nextTrack = getNextTrack(GameState.currentTrack)
                if nextTrack then
                    moveMinecart(nextTrack)
                end
            end
        end
        wait(0.1)
    end
end

local function cleanupPlayerWeld()
    local player = Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local weld = player.Character.HumanoidRootPart:FindFirstChild("PlayerWeld")
        if weld then
            weld:Destroy()
        end
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

local function cleanupMinecart()
    cleanupPlayerWeld()
    if GameState.minecart then
        GameState.minecart:Destroy()
        GameState.minecart = nil
    end
end

cleanupMinecart()
generateTracks()
wait(0.2)
startMinecartRide()
LatestRoom.Changed:Connect(function()
    generateTracks()
end)
