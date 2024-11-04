local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local PathfindingService = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local LocalPlayer = Players.LocalPlayer
local LatestRoom = GameData:WaitForChild("LatestRoom").Value
local LatestRoomInstance = CurrentRooms[tostring(LatestRoom)]

-- Figure Setup
local FigureSet = Instance.new("Folder")
FigureSet.Name = "FigureSetup"
FigureSet.Parent = LatestRoomInstance

local FigureNodesFolder = Instance.new("Folder")
FigureNodesFolder.Name = "FigureNodes"
FigureNodesFolder.Parent = LatestRoomInstance.FigureSetup

local FigureRig = Functions:LoadCustomAsset("https://github.com/vct0721/Doors-Stuff/raw/refs/heads/main/Assets/Hardcore%20FigureRig.rbxm")
FigureRig.Parent = LatestRoomInstance.FigureSetup
LatestRoomInstance:SetAttribute("BeastRoom", true)

local Animu = FigureRig:WaitForChild("AnimSaves")
local proximityTriggered = false

local animations = {
    idle = Animu:WaitForChild("figure_idle"),
    walk = Animu:WaitForChild("figure_walk"),
    run = Animu:WaitForChild("figure_run"),
    fall = Animu:WaitForChild("figure_fall"),
    land = Animu:WaitForChild("figure_land")
}

local animator = FigureRig:WaitForChild("Humanoid"):WaitForChild("Animator")
local pathCache = {}
local recalculationInterval = 2
local PATH_PARAMS = {
    AgentRadius = 2,
    AgentHeight = 5,
    AgentCanJump = false,
}

local function playAnimation(animation)
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play()
    return animationTrack
end

local function calculatePath(destination)
    local path = PathfindingService:CreatePath(PATH_PARAMS)
    path:ComputeAsync(FigureRig.PrimaryPart.Position, destination)
    
    if path.Status == Enum.PathStatus.Complete then
        pathCache = path:GetWaypoints()
    else
        warn("No path found!")
    end
    return path
end

local function moveAlongPath(path, speed)
    if path.Status == Enum.PathStatus.Complete then
        for _, waypoint in ipairs(path:GetWaypoints()) do
            playAnimation(animations.walk)
            FigureRig.Humanoid.WalkSpeed = speed
            FigureRig:MoveTo(waypoint.Position)
            FigureRig.MoveToFinished:Wait()
        end
        playAnimation(animations.idle)
    end
end

local function moveToSoundPosition(soundPosition)
    if soundPosition then
        local path = calculatePath(soundPosition)
        moveAlongPath(path, LocalPlayer.Humanoid.WalkSpeed + 6)
    end
end

local function onPlayerSoundMade(soundPosition)
    if not LocalPlayer:GetAttribute("Crouching") and LatestRoomInstance:GetAttribute("BeastRoom") then
        moveToSoundPosition(soundPosition)
    end
end

local function onProximityPromptTriggered()
    if not LatestRoomInstance:GetAttribute("BeastRoom") then
    proximityTriggered = true
    moveToSoundPosition(LocalPlayer.Character.HumanoidRootPart.Position)
end

local function updateBehavior()
    if proximityTriggered then
        playAnimation(animations.walk)
        FigureRig.Humanoid.WalkSpeed = LocalPlayer.Humanoid.WalkSpeed + 2
        wait(3)
        proximityTriggered = false
        playAnimation(animations.idle)
    else
        playAnimation(animations.idle)
    end
end

while true do
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
	local PreviousLatestRoomInstance = CurrentRooms[tostring(LatestRoom - 1)]
	if PreviousLatestRoomInstance:GetAttribute("BeastRoom") then
	PreviousLatestRoomInstance.FigureSetup:Destroy()
	end)
    updateBehavior()
    wait(recalculationInterval)
end
