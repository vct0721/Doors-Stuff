local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local InsertService = game:GetService("InsertService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LatestRoom = ReplicatedStorage:WaitForChild("GameData").LatestRoom

local TRACK_MODEL_ID = "rbxassetid://77274282170734"
local MINECART_MODEL_ID = "rbxassetid://134508398478924"

local ANIMATIONS = {
    SITTING = "rbxassetid://89511002780891",
    TURN_RIGHT = "rbxassetid://133886478211062",
    TURN_LEFT = "rbxassetid://74584476588827",
    MOVE_STRAIGHT = "rbxassetid://132863810915492"
}

local TRACKS_FOLDER = workspace:FindFirstChild("Tracks") or Instance.new("Folder", workspace)
TRACKS_FOLDER.Name = "Tracks"
local TRACK_SIZE = Vector3.new(6.258, 0.194, 15.869)
local STRAIGHT_SPEED = 1
local TURN_SPEED = 2.5
local MIN_DISTANCE_BETWEEN_NODES = 10

local minecart = nil
local playerInput = nil
local animations = {}

-- Function to load a model from the asset ID
local function loadModel(assetId)
    local objects = game:GetObjects(assetId)
    if #objects > 0 then
        return objects[1]
    else
        return nil
    end
end

-- Function to load an animation
local function loadAnimation(animator, animationId)
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    return animator:LoadAnimation(animation)
end

-- Function to clear all existing rails
local function clearRails()
    for _, rail in pairs(TRACKS_FOLDER:GetChildren()) do
        rail:Destroy()
    end
end

-- Function to create a straight rail
local function createRail(position, cframe, index, parent)
    local newRail = loadModel(TRACK_MODEL_ID)
    if not newRail then return nil end
    newRail.Name = "Rail" .. index
    newRail:SetPrimaryPartCFrame(cframe)
    newRail.Parent = parent
    return newRail
end

-- Function to create bifurcations
local function createBifurcation(parent, previousTrack, isCorrect)
    local bifurcations = {}
    local angles = {-30, 0, 30}
    for i, angle in ipairs(angles) do
        local newCFrame = previousTrack.CFrame * CFrame.Angles(0, math.rad(angle), 0) * CFrame.new(0, 0, TRACK_SIZE.Z)
        local newRail = createRail(newCFrame.Position, newCFrame, #parent:GetChildren() + 1, parent)
        table.insert(bifurcations, newRail)
        if isCorrect and i == 2 then
            newRail.Name = "CorrectTrack"
        else
            newRail.Name = "IncorrectTrack"
        end
    end
    return bifurcations
end

-- Function to calculate the path between two positions
local function calculatePath(startPos, endPos)
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
        AgentJumpHeight = 7,
        AgentMaxSlope = 45,
    })
    path:ComputeAsync(startPos, endPos)
    if path.Status == Enum.PathStatus.Complete then
        return path:GetWaypoints()
    else
        warn("Failed to calculate path.")
        return nil
    end
end

-- Function to filter and adjust waypoints to ensure minimum distance between nodes and smooth inclines
local function filterAndAdjustWaypoints(waypoints)
    local adjustedWaypoints = {}
    for i, waypoint in ipairs(waypoints) do
        if i == 1 or (waypoint.Position - waypoints[i-1].Position).Magnitude >= MIN_DISTANCE_BETWEEN_NODES then
            table.insert(adjustedWaypoints, waypoint)
        end
    end

    for i = 2, #adjustedWaypoints do
        local prevPos = adjustedWaypoints[i-1].Position
        local currPos = adjustedWaypoints[i].Position
        if math.abs(currPos.X - prevPos.X) > math.abs(currPos.Z - prevPos.Z) then
            adjustedWaypoints[i].Position = Vector3.new(currPos.X, currPos.Y, prevPos.Z)
        else
            adjustedWaypoints[i].Position = Vector3.new(prevPos.X, currPos.Y, currPos.Z)
        end

        local prevCFrame = CFrame.new(prevPos)
        local currCFrame = CFrame.new(currPos)

        -- Adjust pitch for inclines
        if currPos.Y ~= prevPos.Y then
            local direction = (currPos - prevPos).Unit
            local pitch = math.asin(direction.Y)
            adjustedWaypoints[i].CFrame = prevCFrame * CFrame.Angles(pitch, 0, 0) * CFrame.new(0, 0, TRACK_SIZE.Z)
        else
            adjustedWaypoints[i].CFrame = prevCFrame:lerp(currCFrame, 1)
        end
    end

    return adjustedWaypoints
end

-- Function to generate tracks dynamically
local function generateTracksForRoom(roomNumber)
    local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(roomNumber))
    if not currentRoom then
        warn("Room "..roomNumber.." not found.")
        return
    end

    local startRoom = currentRoom:FindFirstChild("RoomEntrance")
    local endRoom = currentRoom:FindFirstChild("RoomExit")

    if not startRoom or not endRoom then
        warn("RoomEntrance or RoomExit not found in room "..roomNumber)
        return
    end

    local waypoints = calculatePath(startRoom.Position, endRoom.Position)
    if not waypoints then return end

    waypoints = filterAndAdjustWaypoints(waypoints)

    clearRails()
    local previousTrack = createRail(waypoints[1].Position, waypoints[1].CFrame, 1, TRACKS_FOLDER)
    local normalTrackCount = 0

    for i = 2, #waypoints do
        if normalTrackCount >= 8 then
            createBifurcation(TRACKS_FOLDER, previousTrack.PrimaryPart, true)
            normalTrackCount = 0
        else
            previousTrack = createRail(waypoints[i].Position, waypoints[i].CFrame, i, TRACKS_FOLDER)
            normalTrackCount = normalTrackCount + 1
        end
    end
end

local function onRoomChanged()
    local roomNumber = LatestRoom.Value
    generateTracksForRoom(roomNumber)
    startMinecart()
end

-- Function to move the minecart along the tracks
local function moveMinecart(player)
    local tracks = TRACKS_FOLDER:GetChildren()
    local currentIndex = 1

    while currentIndex <= #tracks do
        local track = tracks[currentIndex]
        local targetCFrame = track.PrimaryPart.CFrame
        local tweenDuration = STRAIGHT_SPEED

        -- Determine the correct animation to play
        if track.Name == "CorrectTrack" then
            tweenDuration = TURN_SPEED
            local nextTrack = tracks[currentIndex + 1]
            if nextTrack then
                local direction = (nextTrack.PrimaryPart.Position - track.PrimaryPart.Position).Unit
                if math.abs(direction.X) > math.abs(direction.Z) then
                    if direction.X > 0 then
                        animations.TURN_RIGHT:Play()
                    else
                        animations.TURN_LEFT:Play()
                    end
                else
                    animations.MOVE_STRAIGHT:Play()
                end
            end
        else
            animations.MOVE_STRAIGHT:Play()
        end

        local tween = TweenService:Create(minecart.PrimaryPart, TweenInfo.new(tweenDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        currentIndex = currentIndex + 1
    end

    if minecart then
        minecart:Destroy()
        minecart = nil
    end
end

-- Function to attach the player to the minecart
local function attachPlayerToMinecart(player, minecart)
    local character = player.Character
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local playerCFrame = minecart:FindFirstChild("PlayerCFrame")

    if not playerCFrame then return end

    rootPart.Anchored = true
    rootPart.CFrame = playerCFrame.CFrame

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = minecart.PrimaryPart
    weld.Parent = rootPart
    wait(0.1)
    rootPart.Anchored = false

    if animations.SITTING then
        animations.SITTING:Play()
    end
end

-- Function to start the minecart
function startMinecart()
    local player = Players.LocalPlayer
    minecart = loadModel(MINECART_MODEL_ID)

    if not minecart then
        warn("Failed to load minecart model.")
        return
    end

    minecart.Parent = workspace
    local animationController = minecart:FindFirstChild("AnimationController")
    if not animationController then
        animationController = Instance.new("AnimationController", minecart)
        animationController.Name = "AnimationController"
    end
    minecartAnimator = animationController:FindFirstChild("Animator") or Instance.new("Animator", animationController)

    animations.SITTING = loadAnimation(player.Character:FindFirstChildOfClass("Humanoid"), ANIMATIONS.SITTING)
    animations.MOVE_STRAIGHT = loadAnimation(minecartAnimator, ANIMATIONS.MOVE_STRAIGHT)
    animations.TURN_RIGHT = loadAnimation(minecartAnimator, ANIMATIONS.TURN_RIGHT)
    animations.TURN_LEFT = loadAnimation(minecartAnimator, ANIMATIONS.TURN_LEFT)

    local initialTrack = TRACKS_FOLDER:FindFirstChildWhichIsA("Model")
    if initialTrack then
        minecart:SetPrimaryPartCFrame(initialTrack.PrimaryPart.CFrame)
    else
        warn("No initial track found.")
        return
    end

    attachPlayerToMinecart(player, minecart)
    moveMinecart(player)
end

-- Main Execution
LatestRoom.Changed:Connect(onRoomChanged)
onRoomChanged() -- Initial call to generate tracks for the first room and start minecart
UserInputService.InputBegan:Connect(onPlayerInput)
