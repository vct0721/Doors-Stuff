local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local vynixuModules = {
	Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
}
local assets = {
	Repentance = LoadCustomInstance("https://github.com/RegularVynixu/Utilities/blob/main/Doors/Entity%20Spawner/Assets/Repentance.rbxm?raw=true")
}

local function getOldestRoom()
	local oldestRoom = nil
	local smallestNumber = math.huge

	for _, room in ipairs(CurrentRooms:GetChildren()) do
		local roomNumber = tonumber(room.Name)
		if roomNumber and roomNumber < smallestNumber then
			smallestNumber = roomNumber
			oldestRoom = room
		end
	end
	return oldestRoom
end

local function moveToNode(entity, node)
	local tween = TweenService:Create(
		entity,
		TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{ Position = node.Position + Vector3.new(0, 6, 0) }
	)
	tween:Play()
	tween.Completed:Wait()
end

local function isPlayerVisible(entity)
	if not Character:FindFirstChild("HumanoidRootPart") then return end
	if not entity or not entity.Position then return end
	local origin = entity.Position
	local playerPos = Character.HumanoidRootPart.Position
	local direction = (playerPos - origin).Unit * (playerPos - origin).Magnitude

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {entity, Character}

	local result = Workspace:Raycast(origin, direction, rayParams)
	return result and result.Instance:IsDescendantOf(Character)
end

local function setPandemoniumEyes(entity, state)
	local eyes = entity:FindFirstChild("PandemoniumEyes")
	if eyes and eyes:IsA("Beam") then
		eyes.Enabled = state
	end
end

local function PlayerHasItemEquipped(name)
	local tool = Character:FindFirstChildOfClass("Tool")
	if tool and tool.Name == name then
		return true, tool
	end
	return false
end

local function KillPlayer()
	local humanoid = Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Health = 0
		firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
			"You died to who you call...", 
			"Pandemonium", 
			"He will rush through the rooms.", 
			"When you hear his screams, try to go out of sight.", 
			"Avoid hiding in a closet when this happens, as he might see you inside. The best thing to do is to find a safe spot out of his sight!"
		} 
		,"Blue")

	end
end

function CrucifixEntity(entityTable, tool)
	local model = entityTable

	local toolPivot = tool:GetPivot()
	local entityPivot = model.CFrame

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {Character, model}
	local result = workspace:Raycast(entityPivot.Position, Vector3.new(0, -1000, 0), params)
	if not result then return end

	model:SetAttribute("BeingBanished", true)

	local repentance = assets.RepentanceNEW:Clone()
	local crucifix = repentance.Crucifix
	local pentagram = repentance.Pentagram
	local entityPart = repentance.Entity
	local sound = crucifix.Sound

	local function waitUntil(t)
		repeat RunService.RenderStepped:Wait() until sound.TimePosition >= t
	end
	local function fadeOut()
		for _, c in pentagram:GetChildren() do
			if c.Name == "BeamFlat" then
				task.delay(c:GetAttribute("Delay"), function()
					TweenService:Create(c, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						Brightness = 0
					}):Play()
				end)
			end
		end
	end

	repentance:PivotTo(CFrame.new(result.Position))
	crucifix.CFrame = toolPivot
	repentance.Entity.CFrame = entityPivot
	crucifix.BodyPosition.Position = (Character:GetPivot() * CFrame.new(0.5, 3, -6)).Position
	repentance.Parent = workspace
	sound:Play()

	task.spawn(function()
		while model.Parent and repentance.Parent do
			model.CFrame = entityPart.CFrame
			task.wait()
		end
		model:Destroy()
	end)
	-- Animation
	TweenService:Create(pentagram.Circle, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { CFrame = pentagram.Circle.CFrame - Vector3.new(0, 25, 0) }):Play()
	TweenService:Create(crucifix.BodyAngularVelocity, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { AngularVelocity = Vector3.new(0, 40, 0) }):Play()
	task.delay(2, pentagram.Circle.Destroy, pentagram.Circle)

	task.spawn(function()
		waitUntil(2.625)
		TweenService:Create(pentagram.Base.LightAttach.LightBright, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
			Brightness = 5,
			Range = 40
		}):Play()
		TweenService:Create(crucifix.Light, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
			Brightness = 11.25,
			Range = 30
		}):Play()
		task.wait(1.5)
		TweenService:Create(pentagram.Base.LightAttach.LightBright, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
			Brightness = 0,
			Range = 0
		}):Play()
		TweenService:Create(crucifix.Light, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
			Brightness = 0,
			Range = 0
		}):Play()
		TweenService:Create(crucifix.Light, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), { Brightness = 15, Range = 40 }):Play()
		fadeOut()
		TweenService:Create(crucifix.BodyAngularVelocity, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { AngularVelocity = Vector3.new() }):Play()
	end)

	-- Actions
	waitUntil(2)
	TweenService:Create(entityPart, TweenInfo.new(3, Enum.EasingStyle.Back, Enum.EasingDirection.In), { CFrame = repentance.Entity.CFrame - Vector3.new(0, 25, 0) }):Play()
	waitUntil(6.75)

	-- Crucifix explode
	TweenService:Create(repentance.Crucifix, TweenInfo.new(1), { Size = repentance.Crucifix.Size * 3, Transparency = 1 }):Play()
	TweenService:Create(repentance.Pentagram.Base.LightAttach.LightBright, TweenInfo.new(1), { Brightness = 0, Range = 0 }):Play()
	TweenService:Create(repentance.Crucifix.Light, TweenInfo.new(1), { Brightness = 0, Range = 0 }):Play()
		model:SetAttribute("BeingBanished", false)
		model:SetAttribute("Paused", false)
		fadeOut()
	task.delay(5, repentance.Destroy, repentance)
end

local function chasePlayer(entity)
	setPandemoniumEyes(entity, true)
	while entity.Parent do
		if not isPlayerVisible(entity) then
			setPandemoniumEyes(entity, false)
			break
		end

		local playerPos = Character.HumanoidRootPart.Position
		local tween = TweenService:Create(
			entity,
			TweenInfo.new(0.5, Enum.EasingStyle.Linear),
			{ Position = playerPos + Vector3.new(0, 6, 0) }
		)
		tween:Play()
		tween.Completed:Wait()

		local distance = (playerPos - entity.Position).Magnitude
		if distance <= 5 then
			local hasCrucifix, tool = PlayerHasItemEquipped("Crucifix")
			if hasCrucifix then
				CrucifixEntity(entity, tool)
				break
			else		
				KillPlayer()
				break
			end	 
		end
		wait(0.1)
	end
end

local function navigateRooms(entity)
	local currentRoom = getOldestRoom()
	if not currentRoom then return end

	while tonumber(currentRoom.Name) <= LatestRoom.Value do
		local pathfindNodes = currentRoom:FindFirstChild("PathfindNodes")
		if pathfindNodes then
			local nodes = pathfindNodes:GetChildren()
			table.sort(nodes, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)

			for _, node in ipairs(nodes) do
				moveToNode(entity, node)

				if isPlayerVisible(entity) then
					chasePlayer(entity)
				end
			end
		end
		local nextRoomNumber = tonumber(currentRoom.Name) + 1
		currentRoom = CurrentRooms:FindFirstChild(tostring(nextRoomNumber))
	end
end
if not Workspace:FindFirstChild("Pandemonium") then
	local Pandemonium = game:GetObjects("rbxassetid://103577032545120")[1]
	Pandemonium.Parent = Workspace
	Pandemonium.Name = "Pandemonium"

	local num = 0
	if getOldestRoom():FindFirstChild("PathfindNodes") then
		num = math.floor(#getOldestRoom().PathfindNodes:GetChildren() / 2)
	end

	Pandemonium.CFrame = (
		num == 0 and CurrentRooms[getOldestRoom().Name] or getOldestRoom().PathfindNodes[num]
	).CFrame + Vector3.new(0, 6, 0)

	task.spawn(function()
		navigateRooms(Pandemonium)
	end)
end
