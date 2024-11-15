-- Sprint script with a toggle button for mobile devices and keyboard support
local Parent = game.Players.LocalPlayer.PlayerGui

local Sprint = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local UIPadding = Instance.new("UIPadding")
local Bar = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIPadding_2 = Instance.new("UIPadding")
local Fill = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")

-- GUI properties
local StaminaGui = Instance.new("ScreenGui")
StaminaGui.Name = "StaminaGui"
StaminaGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
StaminaGui.Enabled = true
StaminaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Sprint.Name = "Sprint"
Sprint.Parent = StaminaGui
Sprint.AnchorPoint = Vector2.new(0, 1)
Sprint.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sprint.BackgroundTransparency = 1.000
Sprint.Position = UDim2.new(0.931555569, 0, 0.987179458, 0)
Sprint.Size = UDim2.new(0.0556001104, 0, 0.0756410286, 0)
Sprint.SizeConstraint = Enum.SizeConstraint.RelativeYY
Sprint.ZIndex = 1005

ImageLabel.Parent = Sprint
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 222, 189)
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
ImageLabel.Visible = false

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ImageLabel

UIPadding.Parent = Sprint
UIPadding.PaddingBottom = UDim.new(0.300000012, -5)
UIPadding.PaddingLeft = UDim.new(0.0199999996, 0)
UIPadding.PaddingRight = UDim.new(0.0500000007, -15)
UIPadding.PaddingTop = UDim.new(0.300000012, -5)

Bar.Name = "Bar"
Bar.Parent = Sprint
Bar.AnchorPoint = Vector2.new(0, 0.5)
Bar.BackgroundColor3 = Color3.fromRGB(56, 46, 39)
Bar.BackgroundTransparency = 0.700
Bar.Position = UDim2.new(-2.72600269, 0, 0.499999672, 0)
Bar.Size = UDim2.new(3.60599804, 0, 0.600000083, 0)
Bar.ZIndex = 0

UICorner_2.CornerRadius = UDim.new(0.25, 0)
UICorner_2.Parent = Bar

UIPadding_2.Parent = Bar
UIPadding_2.PaddingBottom = UDim.new(0, 4)
UIPadding_2.PaddingLeft = UDim.new(0, 4)
UIPadding_2.PaddingRight = UDim.new(0, 4)
UIPadding_2.PaddingTop = UDim.new(0, 4)

Fill.Name = "Fill"
Fill.Parent = Bar
Fill.AnchorPoint = Vector2.new(0, 0.5)
Fill.BackgroundColor3 = Color3.fromRGB(213, 185, 158)
Fill.Position = UDim2.new(0, 0, 0.5, 0)
Fill.Size = UDim2.new(1, 0, 1, 0)
Fill.ZIndex = 2

UICorner_3.CornerRadius = UDim.new(0.25, 0)
UICorner_3.Parent = Fill

-- Adding the toggle button for sprint
local SprintButton = Instance.new("TextButton")
SprintButton.Name = "SprintButton"
SprintButton.Parent = StaminaGui
SprintButton.Size = UDim2.new(0.2, 0, 0.1, 0)
SprintButton.Position = UDim2.new(0.4, 0, 0.85, 0)
SprintButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
SprintButton.Text = "Sprint: OFF"
SprintButton.Visible = true

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variables
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local stamina, staminaMax = 100, 100
local sprintTime = 7
local cooldown = false
local isSprinting = false

local VitaminsActivatedConnection, VitaminsDebounce = nil, false -- For Vitamin handling

local ModuleScripts = {
	MainGame = require(Plr.PlayerGui.MainUI.Initiator.Main_Game),
}

-- Hook for adjusting walk speed dynamically
local nIdx
nIdx = hookmetamethod(game, "__newindex", newcclosure(function(t, k, v)
	if k == "WalkSpeed" then
		if ModuleScripts.MainGame.chase then
			v = ModuleScripts.MainGame.crouching and 15 or 22
		elseif ModuleScripts.MainGame.crouching then
			v = 8
		else
			v = isSprinting and 20 or 12
		end
	end

	return nIdx(t, k, v)
end))

-- Function to start sprinting
local function startSprint()
	if cooldown or ModuleScripts.MainGame.crouching or isSprinting then return end
	isSprinting = true
	Hum:SetAttribute("SpeedBoost", 4)
	TweenService:Create(ImageLabel, TweenInfo.new(0.5), { ImageTransparency = 0 }):Play()
	while isSprinting and stamina > 0 do
		stamina = math.max(stamina - 1, 0)
		Fill.Size = UDim2.new(stamina / staminaMax, 0, 1, 0)
		task.wait(sprintTime / 100)
	end
	if stamina <= 0 then
		isSprinting = false
		Hum:SetAttribute("SpeedBoost", 0)
		cooldown = true
		wait(5) -- Cooldown period
		cooldown = false
	end
end

-- Function to stop sprinting
local function stopSprint()
	if not isSprinting then return end
	isSprinting = false
	Hum:SetAttribute("SpeedBoost", 0)
	TweenService:Create(ImageLabel, TweenInfo.new(1), { ImageTransparency = 1 }):Play()
end

-- Toggle sprint on button click
SprintButton.MouseButton1Click:Connect(function()
	if isSprinting then
		stopSprint()
		SprintButton.Text = "Sprint: OFF"
		SprintButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	else
		startSprint()
		SprintButton.Text = "Sprint: ON"
		SprintButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	end
end)

-- Toggle sprint with keyboard (PC)
UIS.InputBegan:Connect(function(key, gameProcessed)
	if not gameProcessed and key.KeyCode == Enum.KeyCode.Q then
		if isSprinting then
			stopSprint()
		else
			startSprint()
		end
	end
end)

-- Automatically recharge stamina
game:GetService("RunService").RenderStepped:Connect(function()
	if not isSprinting and not cooldown and stamina < staminaMax then
		stamina = math.min(stamina + 1, staminaMax)
		Fill.Size = UDim2.new(stamina / staminaMax, 0, 1, 0)
	end
end)

-- Initialize player attributes
Hum:SetAttribute("SpeedBoost", 0)
Hum.WalkSpeed = 12

-- Vitamin functionality
Char.ChildAdded:Connect(function(CA)
	if CA.Name == "Vitamins" then
		local Tool = Char:FindFirstChild("Vitamins")

		VitaminsActivatedConnection = Tool.Activated:Connect(function()
			if VitaminsDebounce then
				return false
			end

			VitaminsDebounce = true

			-- Restore health and stamina
			Char.Humanoid.Health = Char.Humanoid.Health + 30
			stamina = staminaMax

			-- Reset debounce after 10 seconds
			task.delay(10, function()
				VitaminsDebounce = false
			end)
		end)

		-- Disconnect connection when tool is unequipped
		Tool.Unequipped:Connect(function()
			VitaminsActivatedConnection:Disconnect()
		end)
	end
end)
