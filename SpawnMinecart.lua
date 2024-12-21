-- Services required
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Asset IDs
local TRACK_MODEL_ID = "rbxassetid://77274282170734"
local MINECART_MODEL_ID = "rbxassetid://134508398478924"
local SITTING_ANIMATION_ID = "rbxassetid://89511002780891"
local TURN_RIGHT_ANIMATION_ID = "rbxassetid://133886478211062"
local TURN_LEFT_ANIMATION_ID = "rbxassetid://74584476588827"
local MOVE_STRAIGHT_ANIMATION_ID = "rbxassetid://132863810915492"

-- Folder to hold generated tracks
local TRACKS_FOLDER = workspace:FindFirstChild("Tracks") or Instance.new("Folder", workspace)
TRACKS_FOLDER.Name = "Tracks"

-- Animation and track settings
local BASE_SPEED = 1.2 -- Duration for moving straight
local TURN_SPEED = 2.4 -- Duration for turning (slower)
local ACCELERATION = 0.2 -- Acceleration factor

local minecart = nil
local playerInput = nil

-- Function to load a model using InsertService
local function loadModel(assetId)
    local model = InsertService:LoadAsset(assetId)
    local children = model:GetChildren()
    if #children > 0 then
        return children[1]
    else
        print("Model loading failed. Asset ID:", assetId)
        return nil
    end
end

-- Function to calculate the curve radius based on the distance between tracks
local function calculateCurveRadius(startCFrame, endCFrame)
    local distance = (endCFrame.Position - startCFrame.Position).Magnitude
    return distance / 2  -- A simple calculation for the curve radius
end

-- Function to create a curved track segment
local function createCurvedTrack(parent, startCFrame, endCFrame)
    local track = loadModel(TRACK_MODEL_ID)
    if not track then
        warn("Failed to load track model.")
        return nil
    end
    local midCFrame = startCFrame:lerp(endCFrame, 0.5)
    local curveRadius = calculateCurveRadius(startCFrame, endCFrame)
    local angle = math.deg((endCFrame.Position - startCFrame.Position).Unit:Dot(Vector3.new(1, 0, 0)))
    local segmentCFrame = midCFrame * CFrame.Angles(0, math.rad(angle), 0) * CFrame.new(0, 0, curveRadius)
    track:SetPrimaryPartCFrame(segmentCFrame)
    track.Parent = parent
    return track
end

-- Smooth transition with tilt
local function smoothTransition(minecart, startCFrame, endCFrame, duration, incline)
    local adjustedCFrame = endCFrame * CFrame.Angles(0, 0, math.rad(incline))
    local tween = TweenService:Create(
        minecart.PrimaryPart,
        TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        { CFrame = adjustedCFrame }
    )
    tween:Play()
    return tween
end

-- Generate a track between two points
local function createTrackBetweenPoints(startPos, endPos)
    local track = loadModel(TRACK_MODEL_ID)
    if not track then
        print("Failed to create track.")
        return nil
    end
    local midCFrame = CFrame.new((startPos + endPos) / 2)
    track:SetPrimaryPartCFrame(midCFrame)
    track.Parent = TRACKS_FOLDER
    return track
end

-- Generate bifurcations for a track
local function createBifurcation(track, isCorrect)
    local numBifurcations = math.random(2, 3)
    local bifurcations = {}

    for i = 1, numBifurcations do
        local angle = (i - 2) * 30 -- Spread angles for bifurcations
        local startCFrame = track.PrimaryPart.CFrame
        local endCFrame = startCFrame * CFrame.new(0, 0, 15) * CFrame.Angles(0, math.rad(angle), 0)
        local newTrack = createCurvedTrack(track.Parent, startCFrame, endCFrame)
        if newTrack then
            table.insert(bifurcations, { track = newTrack, cframe = endCFrame })
        end
    end

    -- Mark one track as correct or all as incorrect
    if isCorrect then
        bifurcations[math.random(1, numBifurcations)].track.Name = "CorrectTrack"
    else
        for _, bifurcation in ipairs(bifurcations) do
            bifurcation.track.Name = "IncorrectTrack"
        end
    end

    return bifurcations
end

-- Generate tracks between rooms
local function generateTracksBetweenRooms()
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if not rooms then
        print("No rooms found in workspace.CurrentRooms.")
        return
    end

    for _, room in ipairs(rooms:GetChildren()) do
        local nextRoom = rooms:FindFirstChild(tostring(tonumber(room.Name) + 1))
        if nextRoom then
            local roomExit = room:FindFirstChild("RoomExit")
            local nextRoomEntrance = nextRoom:FindFirstChild("RoomEntrance")

            if roomExit and nextRoomEntrance then
                local track = createTrackBetweenPoints(roomExit.Position, nextRoomEntrance.Position)
                if track then
                    createBifurcation(track, true) -- Add bifurcations after each track
                end
            end
        end
    end
end

-- Move minecart through tracks
local function moveMinecart(player)
    local tracks = TRACKS_FOLDER:GetChildren()
    local inputConnection

    -- Handle player input
    inputConnection = UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.A then
            playerInput = "A"
        elseif input.KeyCode == Enum.KeyCode.D then
            playerInput = "D"
        end
    end)

    for _, track in ipairs(tracks) do
        local bifurcations = track:GetChildren()
        local chosenPath = nil
        local speed = BASE_SPEED -- Default speed

        -- Handle bifurcations if present
        if #bifurcations > 1 then
            if playerInput == "A" then
                chosenPath = bifurcations[1]
                speed = TURN_SPEED -- Slower speed for turns
            elseif playerInput == "D" then
                chosenPath = bifurcations[2]
                speed = TURN_SPEED -- Slower speed for turns
            else
                -- Automatically choose the incorrect path if no input
                for _, bifurcation in ipairs(bifurcations) do
                    if bifurcation.track.Name == "IncorrectTrack" then
                        chosenPath = bifurcation
                        break
                    end
                end
                if not chosenPath then
                    chosenPath = bifurcations[math.random(1, #bifurcations)]
                end
                speed = TURN_SPEED
            end
        elseif #bifurcations == 0 then
            print("No paths available, ejecting player.")
            break
        else
            chosenPath = bifurcations[1]
        end

        smoothTransition(minecart, minecart.PrimaryPart.CFrame, chosenPath.cframe, speed, 0):Completed:Wait()

        if chosenPath.track.Name == "IncorrectTrack" then
            player.Character.Humanoid.Health = 0 -- Kill player on wrong track
            break
        end

        BASE_SPEED = math.min(BASE_SPEED + ACCELERATION, BASE_SPEED * 2)
    end

    inputConnection:Disconnect()
end

-- Attach the player to the minecart
local function attachPlayerToMinecart(player, minecart)
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local playerCFrame = minecart:FindFirstChild("PlayerCFrame")

    if not playerCFrame then
        warn("PlayerCFrame not found in minecart!")
        return
    end

    rootPart.Anchored = true
    rootPart.CFrame = playerCFrame.CFrame

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = minecart.PrimaryPart
    weld.Parent = rootPart
end

-- Start the minecart game logic
local function startMinecart()
    local player = Players.LocalPlayer
    minecart = loadModel(MINECART_MODEL_ID)

    if not minecart then
        return
    end

    minecart.Parent = workspace

    -- Find the latest room and start at RoomEntrance
    local latestRoomNumber = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom").Value
    local latestRoom = workspace.CurrentRooms:FindFirstChild(tostring(latestRoomNumber))
    if latestRoom then
        local roomEntrance = latestRoom:FindFirstChild("RoomEntrance")
        if roomEntrance then
            minecart:SetPrimaryPartCFrame(roomEntrance.CFrame)
            print("Minecart positioned at RoomEntrance of room:", latestRoomNumber)
        else
            warn("RoomEntrance not found in latest room.")
        end
    else
        warn("Latest room not found in CurrentRooms.")
    end

    -- Attach player to the minecart
    attachPlayerToMinecart(player, minecart)

    -- Generate tracks and start movement
    generateTracksBetweenRooms()
    moveMinecart(player)
end

-- Start the game
startMinecart()
