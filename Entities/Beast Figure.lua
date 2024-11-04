local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local PathfindingService = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local roomValue = ReplicatedStorage.GameData.LatestRoom.Value
local LocalPlayer = Players.LocalPlayer
local LatestRoomm = CurrentRooms[tostring(ReplicatedStorage.GameData.LatestRoom.Value)]

-- Figure Setup
local FigureSet = Instance.new("Folder")
FigureSet.Name = "FigureSetup"
FigureSet.Parent = LatestRoomm

local FigurNodesFolder = Instance.new("Folder")
FigurNodesFolder.Name = "FigureNodes"
FigurNodesFolder.Parent = LatestRoomm.FigureSetup

local FigureRig = Functions:LoadCustomAsset("https://github.com/vct0721/Doors-Stuff/raw/refs/heads/main/Assets/Hardcore%20FigureRig.rbxm")
FigureRig.Parent = LatestRoomm.FigureSetup

-- Animations
local Animu = FigureRig:WaitForChild("AnimSaves")
local animations = {
    idle = Animu:WaitForChild("figure_idle"),
    walk = Animu:WaitForChild("figure_walk"),
    run = Animu:WaitForChild("figure_run"),
    fall = Animu:WaitForChild("figure_fall"),
    land = Animu:WaitForChild("figure_land")
}

local animator = FigureRig:WaitForChild("Humanoid"):WaitForChild("Animator")

-- Functions
local function playAnimation(animation)
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play()
    return animationTrack
end

local function CreateNode(Index, Position)
    local Node = Instance.new("Part")
    Node.Name = Index
    Node.Anchored = true
    Node.CanCollide = false
    Node.CanTouch = false
    Node.CanQuery = false
    Node.Shape = Enum.PartType.Ball
    Node.Material = Enum.Material.ForceField
    Node.Size = Vector3.new(2, 2, 2)
    Node.Color = Color3.fromRGB(0, 255, 255)
    Node.Position = Position
    Node.Transparency = 1
    Node.Parent = FigurNodesFolder
end

local function calculateNodeCount(distance)
    local nodeCount = math.clamp(math.floor(distance / 10), 1, 10)
    return nodeCount
end

local function getBestNodes(startPosition, soundPosition)
    local distance = (startPosition - soundPosition).Magnitude
    local nodeCount = calculateNodeCount(distance)

    local success, error = pcall(function()
        local Path = PathfindingService:CreatePath({
            WaypointSpacing = 4,
            AgentRadius = 5,
        })

        Path:ComputeAsync(startPosition, soundPosition)

        local Waypoints = Path:GetWaypoints()

        for Index = 1, math.min(nodeCount, #Waypoints) do
            CreateNode("Node_" .. Index, Waypoints[Index].Position)
        end
    end)

    assert(success, error)
end

local function moveToSoundPosition(soundPosition)
    if soundPosition then
        local path = PathfindingService:CreatePath({
            WaypointSpacing = 4,
            AgentRadius = 5,
        })

        getBestNodes(FigureRig.PrimaryPart.Position, soundPosition)

        path:ComputeAsync(FigureRig.PrimaryPart.Position, soundPosition)
        path:MoveTo(FigureRig)

        playAnimation(animations.run)

        path:MoveToFinished:Wait()

        playAnimation(animations.idle)
    end
end

local function onPlayerSoundMade(soundPosition)
    if not LocalPlayer:GetAttribute("Crouching") then
        moveToSoundPosition(soundPosition)
    end
end

local function onPlayerTouch(other)
    if other:IsA("Player") then
    LocalPlayer.Character.Humanoid:TakeDamage(1000)
	game:GetService("ReplicatedStorage") .GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Beast Figure"
	firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"You died to a Figure Variation", "You call it Beast Figure..", "It can appears in everywhere", "Use what you learnd with Figure"}, "Blue")
    end
end

local playerSound = LocalPlayer:WaitForChild("Sound")
if playerSound then
    playerSound.Played:Connect(function()
        onPlayerSoundMade(playerSound.Position)
    end)
end

FigureRig.PrimaryPart.Touched:Connect(onPlayerTouch)

local function makeNodes(Room: Model)
    local Nodes = getNodes(Room:WaitForChild("RoomEntrance").Position, Room:WaitForChild("RoomExit").Position)
    Nodes.Parent = Room
    return Nodes
end

CurrentRooms.ChildAdded:Connect(makeNodes)
