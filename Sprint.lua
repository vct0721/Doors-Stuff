

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

--Properties:

local StaminaGui = Instance.new("ScreenGui")

--Properties:

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

local erm = Instance.new("ScreenGui")
local ImageLabel = Instance.new("ImageLabel")
erm.IgnoreGuiInset = true
erm.Name = "erm"
erm.Parent = Parent
erm.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageLabel.Parent = erm
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Size = UDim2.new(1, 0, 0.998717964, 0)
ImageLabel.Image = "rbxassetid://190596490"
ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)

ImageLabel.ImageTransparency = 1

-- Services

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

-- Variables

local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")

local stamina, staminaMax = 100, 100
local sprintTime = 7
local cooldown = false

local ModuleScripts = {
	MainGame = require(Plr.PlayerGui.MainUI.Initiator.Main_Game),
}

-- Setup

local nIdx; nIdx = hookmetamethod(game, "__newindex", newcclosure(function(t, k, v)
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

-- Scripts

sprintTime = math.max(sprintTime - 1, 1)
local zerostamtween = game.TweenService:Create(ImageLabel,TweenInfo.new(12),{ImageTransparency = 0})
UIS.InputBegan:Connect(function(key, gameProcessed)
	if not gameProcessed and key.KeyCode == Enum.KeyCode.Q and not cooldown and not ModuleScripts.MainGame.crouching then
		-- Sprinting

isSprinting = true
	if workspace:FindFirstChild("SeekMovingNewClone") then
	    Hum:SetAttribute("SpeedBoost",6)
		zerostamtween:Play()
		while UIS:IsKeyDown(Enum.KeyCode.Q) and stamina > 0 do
			stamina = math.max(stamina - 1, 0)
			Fill.Size = UDim2.new(1 / staminaMax * stamina, 1, 1, 0)
			task.wait(sprintTime / 100)
		end
	else
	     Hum:SetAttribute("SpeedBoost",4)
		zerostamtween:Play()
		 while UIS:IsKeyDown(Enum.KeyCode.Q) and stamina > 0 do
			stamina = math.max(stamina - 1, 0)
			Fill.Size = UDim2.new(1 / staminaMax * stamina, 1, 1, 0)
			task.wait(sprintTime / 100)
			
		end
        end		

		-- Reset
		zerostamtween:Pause()
		isSprinting = false
		Hum:SetAttribute("SpeedBoost",0)
		game.TweenService:Create(ImageLabel,TweenInfo.new(1),{ImageTransparency = 1}):Play()
		Hum.WalkSpeed = 12

		if stamina == 0 then
			-- Cooldown
			firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent,"You're exhausted.")
			local noStamernaSound = Instance.new("Sound",workspace)
			noStamernaSound.SoundId = "rbxassetid://8258601891"
			noStamernaSound.Volume = 0.8
			noStamernaSound.PlayOnRemove = true
			noStamernaSound:Destroy()
			cooldown = true
			game.TweenService:Create(ImageLabel,TweenInfo.new(0.3),{ImageTransparency = 0}):Play()
			wait(0.3)
			game.TweenService:Create(ImageLabel,TweenInfo.new(10),{ImageTransparency = 1}):Play()
			for i = 1, staminaMax, 1 do
				stamina = i
				Fill.Size = UDim2.new(1 / staminaMax * i, 1, 1, 0)

				task.wait(sprintTime / 50)
			end

			cooldown = false
		else
			-- Refill
			cooldown = false
			Spawn(function()
			    --wait(1)
			    cooldown = false
			end)
			game.TweenService:Create(ImageLabel,TweenInfo.new(1),{ImageTransparency = 1}):Play()
			while not UIS:IsKeyDown(Enum.KeyCode.Q) do
				stamina = math.min(stamina + 1, staminaMax)
				Fill.Size = UDim2.new(1 / staminaMax * stamina, 1, 1, 0)

				task.wait(sprintTime / 50)
			end
		end        
	end
end)
Hum:SetAttribute("SpeedBoost",0)
Hum.WalkSpeed = 12
