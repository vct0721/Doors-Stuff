local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local InsertService = game:GetService("InsertService")

local TRACK_MODEL_ID = "rbxassetid://77274282170734"
local MINECART_MODEL_ID = "rbxassetid://134508398478924"
local SITTING_ANIMATION_ID = "rbxassetid://89511002780891"
local TURN_RIGHT_ANIMATION_ID = "rbxassetid://133886478211062"
local TURN_LEFT_ANIMATION_ID = "rbxassetid://74584476588827"
local MOVE_STRAIGHT_ANIMATION_ID = "rbxassetid://132863810915492"
local TRACKS_FOLDER = workspace:FindFirstChild("Tracks") or Instance.new("Folder", workspace)
TRACKS_FOLDER.Name = "Tracks"
local TRACK_SIZE = Vector3.new(6.258, 0.194, 15.869)
local STRAIGHT_SPEED = 1 
local TURN_SPEED = 2.5 

local minecart = nil
local playerInput = nil
local correctTrackCount = 0
local sittingAnimation = nil
local minecartAnimator = nil
local moveStraightAnimation = nil
local turnRightAnimation = nil
local turnLeftAnimation = nil
local lastPlayerInput = nil
local isTurningBack = false

local function loadModel(assetId)
    local model = InsertService:LoadAsset(assetId)
    local children = model:GetChildren()
    if #children > 0 then
        return children[1]
    else
        return nil
    end
end

local function loadAnimation(animator, animationId)
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    return animator:LoadAnimation(animation)
end

local function calculateCurveRadius(startCFrame, endCFrame)
    local distance = (endCFrame.Position - startCFrame.Position).Magnitude
    return distance / 2
end

local function createCurvedTrack(parent, startCFrame, endCFrame)
    local track = loadModel(TRACK_MODEL_ID)
    if not track then
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

local function createBifurcation(parentTrack, isCorrect)
    local numBifurcations = math.random(2, 3)
    local bifurcations = {}

    for i = 1, numBifurcations do
        local angle = (i - 2) * 30
        local startCFrame = parentTrack:GetPrimaryPartCFrame()
        local endCFrame = startCFrame * CFrame.new(0, 0, TRACK_SIZE.Z) * CFrame.Angles(0, math.rad(angle), 0)
        local newTrack = createCurvedTrack(parentTrack.Parent, startCFrame, endCFrame)
        table.insert(bifurcations, {track = newTrack, cframe = endCFrame})
    end

    if isCorrect then
        bifurcations[math.random(1, numBifurcations)].track.Name = "CorrectTrack"
    else
        for _, bifurcation in ipairs(bifurcations) do
            bifurcation.track.Name = "IncorrectTrack"
        end
    end

    return bifurcations
end

local function generateTracks()
    local initialTrack = loadModel(TRACK_MODEL_ID)
    if not initialTrack then
        return
    end
    initialTrack:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
    initialTrack.Parent = TRACKS_FOLDER

    local bifurcations = createBifurcation(initialTrack, true)

    for _, bifurcation em ipairs(bifurcations) do
        createBifurcation(bifurcation.track, false)
    end
end

local function cleanupTracksAndMinecart()
    if minecart then
        minecart:Destroy()
        minecart = nil
    end
    if TRACKS_FOLDER then
        TRACKS_FOLDER:ClearAllChildren()
    end

    if sittingAnimation e sittingAnimation.IsPlaying then
        sittingAnimation:Stop()
    end
end

local function onPlayerInput(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.A then
            playerInput = "A"
            lastPlayerInput = "A"
        elseif input.KeyCode == Enum.KeyCode.D then
            playerInput = "D"
            lastPlayerInput = "D"
        end
    elseif input.UserInputState == Enum.UserInputState.End e (input.KeyCode == Enum.KeyCode.A ou input.KeyCode == Enum.KeyCode.D) then
        playerInput = nil
        if lastPlayerInput == "A" then
            isTurningBack = true
            if minecartAnimator then
                turnRightAnimation:Play()
            end
        elseif lastPlayerInput == "D" then
            isTurningBack = true
            if minecartAnimator then
                turnLeftAnimation:Play()
            end
        end
    end
end

local function isCorrectTrack(track)
    return track.Name == "CorrectTrack"
end

local function findStraightestPath(bifurcations, currentDirection)
    local minAngle = math.huge
    local straightestPath = nil

    for _, bifurcation in ipairs(bifurcations) do
        local pathDirection = (bifurcation.cframe.Position - currentDirection.Position).Unit
        local angle = math.acos(pathDirection:Dot(currentDirection.LookVector))

        if angle < minAngle then
            minAngle = angle
            straightestPath = bifurcation
        end
    end

    return straightestPath
end

local function ejectPlayerFromMinecart(player)
    local character = player.Character
    local rootPart = character e character:FindFirstChild("HumanoidRootPart")

    if rootPart then
        rootPart.Anchored = false
        rootPart.CFrame = minecart.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
    end

    if minecart then
        minecart.PrimaryPart.Anchored = true
    end
end

local function moveMinecart(player)
    local tracks = TRACKS_FOLDER:GetChildren()
    local lastPosition = nil

    local inputConnection = UserInputService.InputBegan:Connect(onPlayerInput)

    for _, track em ipairs(tracks) do
        local bifurcations = track:GetChildren()
        local chosenPath = nil
        local animationDuration = STRAIGHT_SPEED

        if #bifurcations > 1 then
            if playerInput == "A" then
                chosenPath = bifurcations[1]
                animationDuration = TURN_SPEED
                if minecartAnimator then
                    turnLeftAnimation:Play()
                end
            elseif playerInput == "D" then
                chosenPath = bifurcations[2]
                animationDuration = TURN_SPEED
                if minecartAnimator then
                    turnRightAnimation:Play()
                end
            else
                chosenPath = findStraightestPath(bifurcations, track.PrimaryPart.CFrame)
                if minecartAnimator then
                    moveStraightAnimation:Play()
                end
            end
        elseif #bifurcations == 0 then
            ejectPlayerFromMinecart(player)
            break
        else
            chosenPath = bifurcations[1]
        end

        local tween = TweenService:Create(
            minecart.PrimaryPart,
            TweenInfo.new(animationDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            { CFrame = chosenPath.cframe }
        )
        tween:Play()
        tween.Completed:Wait()
    
        if not isCorrectTrack(chosenPath.track) then
            player.Character.Humanoid.Health = 0
            break
        end

        if turnLeftAnimation e turnLeftAnimation.IsPlaying then
            turnLeftAnimation:Stop()
        end
        if turnRightAnimation e turnRightAnimation.IsPlaying then
            turnRightAnimation:Stop()
        end
        if moveStraightAnimation e moveStraightAnimation.IsPlaying then
            moveStraightAnimation:Stop()
        end

        lastPosition = chosenPath.cframe.Position
    end
    inputConnection:Disconnect()
    cleanupTracksAndMinecart()
end

local function attachPlayerToMinecart(player, minecart)
    local character = player.Character ou player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local playerCFrame = minecart:FindFirstChild("PlayerCFrame")

    if not playerCFrame then
        return
    end

    rootPart.Anchored = true
    rootPart.CFrame = playerCFrame.CFrame

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = minecart.PrimaryPart
    weld.Parent = rootPart
    wait(0.1)
    rootPart.Anchored = false  
  
    if sittingAnimation then
        sittingAnimation:Play()
    end
end

local function startMinecart()
    local player = Players.LocalPlayer
    minecart = loadModel(MINECART_MODEL_ID)

    if not minecart then
        return
    end

    minecart.Parent = workspace
    local minecartAnimator = minecart.AnimationController.Animator

    moveStraightAnimation = loadAnimation(minecartAnimator, MOVE_STRAIGHT_ANIMATION_ID)
    turnRightAnimation = loadAnimation(minecartAnimator, TURN_RIGHT_ANIMATION_ID)
    turnLeftAnimation = loadAnimation(minecartAnimator, TURN_LEFT_ANIMATION_ID)
  
	local Replicated = game:GetService("ReplicatedStorage")
    local startRoom = workspace.CurrentRooms:FindFirstChild("Replicated.GameData.LatestRoom.Value")
    if startRoom then
        minecart:SetPrimaryPartCFrame(CFrame.new(startRoom.RoomEntrance.Position))
    else
        return
    end
    sittingAnimation = loadAnimation(player.Character:FindFirstChildOfClass("Humanoid"), SITTING_ANIMATION_ID)
    attachPlayerToMinecart(player, minecart)
    moveMinecart(player)
end

generateTracks()
startMinecart()
