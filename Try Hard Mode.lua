local whitelisteds = {"Executor"}

local blacklisteds = {"???"}

if table.find(blacklisteds, game.Players.LocalPlayer.Name) and not table.find(whitelisteds, game.Players.LocalPlayer.Name) then
	game.Players.LocalPlayer:Kick("You has been blacklisted from Tryhard Mode for unambiguous use or something 🚫")
end

if game:GetService("ReplicatedStorage"):FindFirstChild("TryHarder") then
	warn("You have Already Loaded TryHard Mode /(Returning/)")
	game.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("You have Already Loaded TryHard Mode /(Returning/)")
	return
end

local Test = Instance.new("Part")
Test.Name = "TryHarder"
Test.Parent = game:GetService("ReplicatedStorage")

game.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("Wait a few seconds this loading to open the door!")

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Tryhard Mode script succesfully executed (version 3)", true)

-- Setting up Locals
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
local IsInsaneMines = false
local IsDeepHotel = false
local IsGlitched = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local PathfindingService = game:GetService("PathfindingService")
local Workspace = game:GetService("Workspace")
local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local roomValue = LatestRoom.Value
local floorValue = GameData.Floor.Value
local IsRetro = GameData.Floor.Value == "Retro"
local IsMines = GameData.Floor.Value == "Mines"
local IsRooms = GameData.Floor.Value == "Rooms"
local IsHotel = GameData.Floor.Value == "Hotel"
local IsBackHotel = GameData.Floor.Value == "Backdoor"
local LatestRoomm = CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]
local NextRoomm = CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value + 1]
local RoomAssets = LatestRoomm:WaitForChild("Assets")
local TeleportService = game:GetService("TeleportService")
local IsMiddleFloor = ReplicatedStorage.GameData.LatestRoom.Value == 50
local IsHospital = IsHotel and ReplicatedStorage.GameData.LatestRoom.Value == 60
local IsCourtyard = ReplicatedStorage.GameData.LatestRoom.Value == 90
local IsGreenHouse = ReplicatedStorage.GameData.LatestRoom.Value > 90 and ReplicatedStorage.GameData.LatestRoom.Value < 100
local IsEletrical = ReplicatedStorage.GameData.LatestRoom.Value == 100 and IsHotel
local ModuleEvents = require(ReplicatedStorage.ClientModules.Module_Events)
local IsDead = LocalPlayer.Character and LocalPlayer.Character.Humanoid and LocalPlayer.Character.Humanoid.Health <= 0
local IsBackEnd = IsBackHotel and ReplicatedStorage.GameData.LatestRoom.Value == 50
local IsFinalRooms = IsRooms and ReplicatedStorage.GameData.LatestRoom.Value == 1000
local IsSeekChase = Workspace:FindFirstChild("SeekMovingNewClone") or Workspace:FindFirstChild("SeekMoving")
local IsFigure = LatestRoomm:FindFirstChild("FigureRig") or LatestRoomm:FindFirstChild("FigureSetup") or NextRoomm:FindFirstChild("FigureRig") or NextRoomm:FindFirstChild("FigureSetup")
local IsHalt = LatestRoomm:GetAttribute("RawName") == "HaltHallway" or NextRoomm:GetAttribute("RawName") == "HaltHallway"
local IsGrumble = IsMines and IsMiddleFloor

-- Functions
function GitPNG(GithubImg,ImageName)
	local url=GithubImg
	if not isfile(ImageName..".png") then
		writefile(ImageName..".png", game:HttpGet(url))
	end
	return (getcustomasset or getsynasset)(ImageName..".png")
end

function ReplaceAudGit(GithubSnd, SoundName)
	local url = GithubSnd
	if not isfile(SoundName .. ".mp3") then
		writefile(SoundName .. ".mp3", game:HttpGet(url))
	end
	return (getcustomasset or getsynasset)(SoundName .. ".mp3")
end

function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
	local Url = GithubSoundPath

	if not isfile(AssetName..".mp3") then 
		writefile(AssetName..".mp3", game:HttpGet(Url)) 
	end

	local Sound = Instance.new("Sound")
	Sound.SoundId = (getcustomasset or getsynasset)(AssetName..".mp3")
	return Sound 
end

-- New Seek Model(Remade)
loadstring(game:HttpGet("https://pastefy.app/dVfwY1Ts/raw"))()

-- Ambience

coroutine.wrap(function()

	if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			wait(0.0005)

			local function ReplaceAudGit(GithubSnd, SoundName)
				local url = GithubSnd
				if not isfile(SoundName .. ".mp3") then
					writefile(SoundName .. ".mp3", game:HttpGet(url))
				end
				return (getcustomasset or getsynasset)(SoundName .. ".mp3")
			end

            if Workspace:FindFirstChild("50") then
			game.Workspace.CurrentRooms["50"].FigureSetup.Ambience.SoundId = ReplaceAudGit("https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Figure%20Ambience.mp3?raw=true", "NewFigure")
			game.Workspace.CurrentRooms["50"].FigureSetup.AmbienceEnd.SoundId = ReplaceAudGit("https://github.com/Sosnen/Ping-s-Dumbass-projects-/blob/main/Figure%20Start.mp3?raw=true", "NewFigureStart")
			game.Workspace.CurrentRooms["50"].FigureSetup.AmbienceStart.SoundId = ReplaceAudGit("https://github.com/Sosnen/Ping-s-Dumbass-projects-/blob/main/Figure%20End.mp3?raw=true", "NewFigureEnd")
            end
		end)

		--[[ ]]--

	end

end)()

-- light's shatter in the library and the dam

coroutine.wrap(function()

	if IsHotel then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			if roomValue == 50 or roomValue == 100 then

				wait(6.4941)

				local currentrooms = game.Workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]

				ModuleEvents.shatter(currentrooms)

			end

		end)

	elseif IsMines then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			if roomValue == 100 or roomValue == 50 then

				wait(6.4941)

				local currentrooms = game.Workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]

				ModuleEvents.shatter(currentrooms)

			end

		end)

		--[[ ]]--

	end

end)()

local anchorableClasses = {
	"Part",
	"MeshPart",
	"Wedge",
	"TrussPart",
	"CornerWedgePart",
	"BallSocketConstraint",
	"UnionOperation",
}

-- New Seek Eyes
local EyeAssetIDs = {
	"rbxassetid://13394794877",
	"rbxassetid://11854254581",
	"rbxassetid://12565218408",
	"rbxassetid://11717372116",
	"rbxassetid://7221790162",
	"rbxassetid://12739517222",
	"rbxassetid://13493469129",
}

function ChangeEyeModel(room)
	for i, v in pairs(room:GetDescendants()) do
		if v.Name == "Eye" then
			if game.ReplicatedStorage.GameData.LatestRoom.Value < 100 then
				local randomIndex = math.random(1, #EyeAssetIDs)
				local eye = game:GetObjects(EyeAssetIDs[randomIndex])[1]
				if eye then
					for _, className in ipairs(anchorableClasses) do
						for _, part in pairs(eye:GetDescendants()) do
							if part:IsA(className) or part:IsA("BasePart") then
								part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
								part.CanCollide = false
								part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								part.Anchored = false
							end
						end
					end

					eye.Parent = v.Parent
					eye.Name = "NewEye"
					eye:PivotTo(v:GetPivot())

					wait(0.2)

					v:Destroy()
					for _, className in ipairs(anchorableClasses) do
						for _, part2 in pairs(eye:GetDescendants()) do
							if part2:IsA(className) or part2:IsA("BasePart") then
								part2.Anchored = true
								part2.CanCollide = true
							end
						end
					end
				end
			end
		end
	end
end

function ChangeDamModel(room)
	for i, v in pairs(room:GetDescendants()) do
		if v.Name == "True Seek" or v.Name == "TrueSeek" then
			if game.ReplicatedStorage.GameData.LatestRoom.Value == 100 and IsMines then
				local eye = LoadCustomInstance("https://github.com/vct0721/Doors-Stuff/raw/refs/heads/main/Assets/DamSeek%20New.rbxm")
				if eye then
					for _, className in ipairs(anchorableClasses) do
						for _, part in pairs(eye:GetDescendants()) do
							if part:IsA(className) or part:IsA("BasePart") then
								part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
								part.CanCollide = false
								part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
								part.Anchored = false
							end
						end
					end

					eye.Parent = v.Parent
					eye.Name = v.Name
					eye:PivotTo(v:GetPivot())

					wait(0.2)

					v:Destroy()
					for _, className in ipairs(anchorableClasses) do
						for _, part2 in pairs(eye:GetDescendants()) do
							if part2:IsA(className) or part2:IsA("BasePart") then
								part2.Anchored = true
								part2.CanCollide = true
							end
						end
					end
				end
			end
		end
	end
end

GameData.LatestRoom.Changed:Connect(function()
	ChangeDamModel(LatestRoomm)
	ChangeEyeModel(LatestRoomm)
end)

-- Ambience New Sounds

loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/QOL/Ambient.lua"))()

-- Songs
local CuriousHumm = getGitSoundId("https://github.com/ChronoAcceleration/Comet-Development/blob/main/Doors/Assets/Horror/Curious%20Humm.mp3?raw=true", "CuriousHumm")
CuriousHumm.Parent = SoundService
local MischievousHumm = getGitSoundId("https://github.com/ChronoAcceleration/Hotel-Plus-Plus/blob/main/Assets/MischeviousHum.mp3?raw=true", "MischievousHumm")
CuriousHumm.Parent = SoundService

-- Sprint: 
loadstring(game:HttpGet("https://pastefy.app/b3XxH7yw/raw"))()

-- Ambient dark sound
game.Workspace.Ambience_Dark.SoundId = "rbxassetid://6535784827"
game.Workspace.Ambience_Dark.PlaybackSpeed = 1

-- Echo sound
game.SoundService.AmbientReverb = "ConcertHall"

-- Death Sound 
game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.Music.Blue.SoundId = "rbxassetid://10472612727"

wait(0.1)  

game.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage("Ok, it's works now, you can finally open the door!")

-- Node's Fixings (Credits to Official_Artemis And Chrono)

coroutine.wrap(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/refs/heads/main/Other/NodesConverter.lua"))()
end)()


-- Script Start
LatestRoom.Changed:Wait()

wait(0.5)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Script sync's accordingly for started room",true)

wait(1)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Made By victor072134",true)

wait(1)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Credits to Official_Artemis, Kotyara19k, Noonie, huyhoanphuc, Ping, Noah, Chrono, Vynixu, Ame, Zavaled",true)

-- Intro in the Special Rooms

coroutine.wrap(function()

	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

		if game.ReplicatedStorage.GameData.LatestRoom.Value == 100 and IsHotel then

			local spawn_nm = Instance.new("Sound", workspace)
			spawn_nm.SoundId = "rbxassetid://4676040750"
			spawn_nm.Volume = 1
			spawn_nm:Play()
			local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
			local intro = shut:Clone()
			intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
			intro.Name = "_EletricalIntro"
			intro.Visible = true
			intro.Text = "The Eletrical Room"
			intro.TextTransparency = 0
			local underline = UDim2.new(1.1, 0, 0.015, 6)
			game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
			wait(7)
			game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
			wait(1)
			game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
			game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
			game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
			wait(2.3)
			intro.Visible = false
			wait(8)
			intro:Destroy()	

		elseif game.ReplicatedStorage.GameData.LatestRoom.Value == 89 and IsHotel then

			local CustomMusic = getGitSoundId("https://github.com/ChronoAcceleration/Comet-Development/raw/refs/heads/main/Doors/Assets/Horror/CourtyardEntry.mp3", "_CourtyardEntrance")
			CustomMusic.Parent = game:GetService("SoundService")
			CustomMusic.Looped = false
			CustomMusic:Play()
			local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
			local intro = shut:Clone()
			intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
			intro.Name = "_CourtyardIntro"
			intro.Visible = true
			intro.Text = "The Courtyard"
			intro.TextTransparency = 0
			local underline = UDim2.new(1.1, 0, 0.015, 6)
			game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
			wait(7)
			game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
			wait(1)
			game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
			game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
			game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
			wait(2.3)
			intro.Visible = false
			wait(8)
			intro:Destroy()
			CustomMusic.Ended:Wait()
			CustomMusic:Destroy()

		elseif game.ReplicatedStorage.GameData.LatestRoom.Value == 50 and IsHotel then

			local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
			local intro = shut:Clone()
			intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
			intro.Name = "_LibraryIntro"
			intro.Visible = true
			intro.Text = "The Library"
			intro.TextTransparency = 0
			local underline = UDim2.new(1.1, 0, 0.015, 6)
			game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
			wait(7)
			game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
			wait(1)
			game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
			game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
			game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
			wait(2.3)
			intro.Visible = false
			wait(8)
			intro:Destroy()	

		elseif game.ReplicatedStorage.GameData.LatestRoom.Value == 50 and IsMines then

			local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
			local intro = shut:Clone()
			intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
			intro.Name = "_NestIntro"
			intro.Visible = true
			intro.Text = "The Nest"
			intro.TextTransparency = 0
			local underline = UDim2.new(1.1, 0, 0.015, 6)
			game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
			wait(7)
			game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
			wait(1)
			game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
			game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
			game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
			wait(2.3)
			intro.Visible = false
			wait(8)
			intro:Destroy()

		elseif game.ReplicatedStorage.GameData.LatestRoom.Value == 100 and IsMines then

			local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
			local intro = shut:Clone()
			intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
			intro.Name = "_DamIntro"
			intro.Visible = true
			intro.Text = "The Dam (The Sewers)"
			intro.TextTransparency = 0
			local underline = UDim2.new(1.1, 0, 0.015, 6)
			game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
			wait(7)
			game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
			wait(1)
			game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
			game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
			game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
			wait(2.3)
			intro.Visible = false
			wait(8)
			intro:Destroy()		

		end

	end)

end)()

-- Intro text
if IsHotel then
	loadstring(game:HttpGet("https://pastebin.com/raw/kZbzXWz3"))()
elseif IsMines then
	loadstring(game:HttpGet("https://pastebin.com/raw/VWwphst3"))()
elseif IsRooms then    
	loadstring(game:HttpGet("https://pastebin.com/raw/BsKmjS02"))()
elseif IsBackHotel then
	loadstring(game:HttpGet("https://pastebin.com/raw/iduWjT1k"))()
end

-- Setting up horror sound
local horrorSound = getGitSoundId("https://github.com/nervehammer1/throwawaystuff/raw/refs/heads/main/NightmareAmbient.mp3", "NightmareModeAmbient")
horrorSound.Parent = game:GetService("SoundService")
horrorSound.Looped = true
horrorSound:Play()

-- Screech setup

coroutine.wrap(function()

	if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then

		while true do

			wait(0.1)

			game.ReplicatedStorage.Entities.Screech.Top.Eyes.Color = Color3.fromRGB(255, 255, 0)
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Caught.SoundId = "rbxassetid://7492033495"
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Caught.PlaybackSpeed = 1.6
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Scary.SoundId = "rbxassetid://7492033495"
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Scary.PlaybackSpeed = 1.6
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Attack.SoundId = "rbxassetid://8080941676"

		end

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Mines" then

		while true do

			wait(0.1)

			game.ReplicatedStorage.Entities.Screech.Top.Eyes.Color = Color3.fromRGB(255, 255, 0)
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Caught.SoundId = "rbxassetid://7492033495"
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Caught.PlaybackSpeed = 1.6
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Scary.SoundId = "rbxassetid://7492033495"
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Scary.PlaybackSpeed = 1.6
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Attack.SoundId = "rbxassetid://8080941676"

		end

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Fools" then

		game.ReplicatedStorage.Entities.Screech.Top.Eyes.Color = Color3.fromRGB(255, 255, 0)
		game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Attack.SoundId = "rbxassetid://8080941676"

		--[[ ]]--

	end

end)()

-- Ambience
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/QOL/DoorSounds.lua"))()
coroutine.wrap(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		coroutine.wrap(function()
			if floorValue == "Hotel" then
				game.ReplicatedStorage.Sounds.BulbCharge.SoundId = "rbxassetid://9125973984"
				game.ReplicatedStorage.Sounds.BulbZap.SoundId = "rbxassetid://4288784832"
				game.ReplicatedStorage.Sounds.BulbBreak.SoundId = "rbxassetid://6737582273"

			elseif floorValue == "Mines" then
				game.ReplicatedStorage.Sounds.BulbCharge.SoundId = "rbxassetid://9125973984"
				game.ReplicatedStorage.Sounds.BulbZap.SoundId = "rbxassetid://4288784832"
				game.ReplicatedStorage.Sounds.BulbBreak.SoundId = "rbxassetid://6737582273"

			elseif floorValue == "Backdoor" then
				game.ReplicatedStorage.Sounds.BulbZap.SoundId = "rbxassetid://5857559198"
				game.ReplicatedStorage.Sounds.BulbBreak.SoundId = "rbxassetid://260496290"
			end
		end)()

		-- Increase fireplace brightness if on the Hotel
		coroutine.wrap(function()
			if IsHotel then
				game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
					wait(0.0005)
					local room = game.Workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]
					local fireplace = room and room.Assets.Fireplace.Fireplace_Logs.Log
					if fireplace then
						fireplace.FireLight.Brightness = 25
					end
				end)
			end
		end)()

	end)
end)()

-- Model Variations
if IsHotel then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/QOL/PlantVariants.lua"))()
end

local function convertMiscLight(Light: Part, Music: Sound): ()
	local HelpParticle = Light.HelpParticle
	HelpParticle.Color = ColorSequence.new(Color3.fromRGB(255, 126, 126))
	HelpParticle.Rate = 10

	Music.Parent = Light
	Music.Looped = true
	Music.RollOffMaxDistance = 100
	Music.RollOffMinDistance = 0
	Music.RollOffMode = Enum.RollOffMode.Linear
	Music.Volume = 0.5
	Music:Play()

	for _, PointLight: PointLight in Light:GetChildren() do
		if not PointLight:IsA("PointLight") then
			continue
		end

		PointLight.Brightness = 1
		PointLight.Color = Color3.fromRGB(255, 142, 134)

		local Change = PointLight:GetPropertyChangedSignal("Brightness"):Connect(
			function(): ()
				if PointLight.Brightness ~= 1 then
					PointLight.Brightness = 1
				end
			end
		)

		task.delay(
			1,
			function(): ()
				Change:Disconnect()
			end
		)

		if not PointLight.Shadows then
			PointLight.Shadows = true
		end
	end
	wait(1.9)
	PointLight.Brightness = 0
	PointLight.Color = Color3.fromRGB(0, 0, 0)
	wait(1.9)
	Light:Destroy()	
end

local function convertHelpfulLight(Light: Part, Music: Sound): ()
	local HelpParticle = Light.HelpParticle
	HelpParticle.Color = ColorSequence.new(Color3.fromRGB(255, 238, 0))
	HelpParticle.Rate = 10

	Music.Parent = Light
	Music.Looped = true
	Music.RollOffMaxDistance = 100
	Music.RollOffMinDistance = 0
	Music.RollOffMode = Enum.RollOffMode.Linear
	Music.Volume = 0.5
	Music:Play()

	for _, PointLight: PointLight in Light:GetChildren() do
		if not PointLight:IsA("PointLight") then
			continue
		end

		PointLight.Brightness = 1
		PointLight.Color = Color3.fromRGB(255, 238, 55)

		local Change = PointLight:GetPropertyChangedSignal("Brightness"):Connect(
			function(): ()
				if PointLight.Brightness ~= 1 then
					PointLight.Brightness = 1
				end
			end
		)

		task.delay(
			5,
			function(): ()
				Change:Disconnect()
			end
		)

		if not PointLight.Shadows then
			PointLight.Shadows = true
		end
	end
end

CurrentRooms.DescendantAdded:Connect(
	function(Asset: Instance): ()
		local gjm = math.random(1, 15)
		if Asset.Name == "HelpfulLight" and (gjm == 4 or gjm == 2) then
			convertHelpfulLight(Asset, CuriousHumm:Clone())
		elseif Asset.Name == "HelpfulLight" and gjm == 6 then
			convertMiscLight(Asset, MischievousHumm:Clone())
		end
	end
)


-- Entities Section

--Giggle in Other Floors

coroutine.wrap(function()

	while true do

		if not IsMines then

			wait(math.random(1, 5))

			getgenv().GIGGLE_SPAWN_CONFIG = {
				Damage = math.random(6, 10),
				AttackingTime =  math.random(7, 10), -- The time giggle will be attacking for.
				FallSpeed =  math.random(2, 3),        -- Speed for when giggle spawns, can be mininum 2 and how high you want

				Stunnable = true,    -- If set to true, Giggle will be stunnable with glowstick
				StunTime = 5, -- The time giggle will be stun for

				RagdollThrowForce = 50,    -- The Ragdoll's Force when its thrown
				RagdollDissapears = true,  -- If set to true the ragdoll will dissapear once giggle finishes attacking.

				RoomSpawning = {
					Enabled = true   -- If set to false, giggle will spawn around the player.
				},

				PlayerSpawning = { -- This table will be used if Room Spawning is Disabled
					MinRadius = -20,  -- The minimum distance giggle can spawn from the player.
					MaxRadius = 20.  --  The maximum distance giggle can spawn from the player.
				},

				SpawningKey = { -- Key for Spawning
					Enabled = false,  -- If enabled once the key is pressed, giggle will spawn.
					Key = "G"    -- Key that is used for spawning giggle
				}
			}

			loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Test/refs/heads/main/Doors/GiggleSpawn.lua"))()


		end

	end

end)()

-- Depth

coroutine.wrap(function()

	while true do

		if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
			if IsMines then
				wait(math.random(290, 330))
				LatestRoom.Changed:Wait()

				local cue2 = Instance.new("Sound")
				cue2.Parent = game.Workspace
				cue2.Name = "Spawn"
				cue2.SoundId = "rbxassetid://8627516764"
				cue2.Volume = 1
				cue2.PlaybackSpeed = 1
				cue2:Play()
				game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(0, 100, 255)
				game.Lighting.MainColorCorrection.Contrast = 5
				local tween = game:GetService("TweenService")
				tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(2.5), {Contrast = 0}):Play()
				local TweenService = game:GetService("TweenService")
				local TW = TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5),{TintColor = Color3.fromRGB(255, 255, 255)})
				TW:Play()
				loadstring(game:HttpGet("https://pastebin.com/raw/uyYe9bZQ"))()

			end

		end

	end

end)()

-- Paralysis
coroutine.wrap(function()
	while true do
		wait(29.50)
		if IsBackHotel then
			if not IsSeekChase or IsFigure then
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/FI91Bi2f/raw"))()
			end
		end
	end
end)()	

-- Greed
coroutine.wrap(function()
	while true do
		wait(450)
		game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
		if IsFigure or IsSeekChase or IsHalt or IsGrumble then
			return
		end

		local ded = false
		local gone = false

		local sound = Instance.new("Sound",game.Lighting)
		sound.SoundId = "rbxassetid://166047422"
		sound.Volume = 5
		sound:Play()

		if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
			ded = true
		end

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
			if gone == false then
				if ded == false then
					game.Players.LocalPlayer.Character.Humanoid.Health = 0
					if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then 
						ded = true
						loadstring(game:HttpGet("https://raw.githubusercontent.com/check78/Jumpscares/main/GreedJumpscare.txt"))()
						game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Greed"
						wait(1)
						local Achievements = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
						Achievements({
							Title = "Too Greedy.",
							Desc = "Greedness",
							Reason = "Die to Greed",
							Image = GitPNG("https://github.com/check78/worldcuuuup/blob/main/GreedBadge1.png?raw=true","GreedyBadge")
						})
					end
				end
			end
		end)

		local tweenColor = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(2), {Contrast = -0.19})
		tweenColor:Play()
		local tweenSat = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(2), {Saturation = -0.19})
		tweenSat:Play()
		local TW2 = game.TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(2),{TintColor = Color3.fromRGB(255, 191, 154)})
		TW2:Play()
		wait(5.7)
		local tween = game:GetService("TweenService")
		tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(4), {Contrast = 0}):Play()
		tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(4), {Saturation = 0}):Play()
		local TW = game.TweenService:Create(game.Lighting.MainColorCorrection, TweenInfo.new(4),{TintColor = Color3.fromRGB(255, 255, 255)})
		TW:Play()
		gone = true
	end
end)()

-- Dread (FG)
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(90, 130))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/DreadEnity"))()
			end
		end
	end
end)()

-- Dreadfestation (OG Dread)
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(80, 130))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				spawn(function()
					require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Dread)(require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
				end)
				repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.DreadVignette.Visible == true
				wait(1)
				repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.DreadVignette.ImageColor3 ~= Color3.fromRGB(0,0,0) or not workspace:FindFirstChild('Dread')
				if not workspace:FindFirstChild("Dread") then
					---====== Load achievement giver ======---
					local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

					---====== Display achievement ======---
					achievementGiver({
						Title = "Death Of Night",
						Desc = "Tick tock goes the another clock...",
						Reason = "Encounter Dreadfestation",
						Image = GitPNG("https://github.com/vct0721/Doors-Stuff/raw/main/Assets/36426864382.png","DreadfestBadge")
					})
					
					return
				end
				game:GetService("ReplicatedStorage") .GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Dread"
				spawn(function()
					require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscares.Dread) (require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
				end)
				wait(1)
				pcall(function()
					firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"Hello, it's me again", "You died to one more of the Dread Variations", "This one, they call it Dreadfestation..", "It can appears out of nowhere", "Try not to stall. Keep moving!"}, "Yellow")
				end)
				wait(1)
				game.Players.LocalPlayer.Character.Humanoid.Health = 0
			end
		end
	end
end)()

-- Nightmare Hunger
coroutine.wrap(function()

	while true do

		wait(math.random(35, 600))

		local spawn_chance = math.random(1, 100)

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

		local roomy = game.ReplicatedStorage.GameData.LatestRoom.Value

		local spawn_nm = Instance.new("Sound", workspace)

		spawn_nm.SoundId = "rbxassetid://933230732"

		spawn_nm.Volume = 1

		spawn_nm:Play()

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(1)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		wait(.5)

		if roomy ~= game.ReplicatedStorage.GameData.LatestRoom.Value then

			game.Players.LocalPlayer.Character.Humanoid.Health = 0

			local killmsg = {"Why did you open the door...", "Try not to open the door during nightmare hunger's scream next time!"}

			local plr = game:GetService("Players").LocalPlayer

			game.ReplicatedStorage.GameStats["Player_".. plr.Name].Total.DeathCause.Value = "Nightmare Hunger [Opened Door]"

			firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, killmsg, "Blue")

		end

		loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/HUNGERcrux"))()

	end

end)()

-- Cease
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(150, 230))
			if not IsSeekChase or IsFigure or IsHalt then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/AaIrbcZS/raw"))()
			end
		end
	end
end)()

-- Frostbite
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(150, 250))
			if not IsSeekChase or IsFigure or IsHalt or IsMines then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/Zb1au2BU/raw"))()
			end
		end
	end
end)()

-- A-60
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(250, 380))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/q0JC9BAt"))()
			end
		end
	end
end)()

-- A-60(HC)
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(350, 680))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/huyhoanggphuc/Entity-obfuscate/refs/heads/main/A-60%20Hardcore.lua"))()
			end
		end
	end
end)()

-- Threat
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(80, 520))
			if not IsSeekChase or IsFigure or IsHalt or IsMines then
				LatestRoom.Changed:Wait()
				wait(2)
				loadstring(game:HttpGet("https://raw.githubusercontent.com/huyhoanggphuc/Entity-obfuscate/refs/heads/main/Threat.lua"))()
			end
		end
	end
end)()

-- Twister
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(20, 95))
			if not IsSeekChase or IsFigure or IsHalt then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/huyhoanggphuc/Entity-obfuscate/refs/heads/main/Twister.lua"))()
			end
		end
	end
end)()

-- Deer God
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(250, 400))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/17nNEGQe/raw"))()
			end
		end
	end
end)()

-- Pandemonium
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(650, 990))
			if not IsSeekChase or IsFigure or IsHalt then
				LatestRoom.Changed:Wait()
				wait(2)
				loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/refs/heads/main/Entities/Pandemonium.lua"))()
			end		
		end
	end
end)()

-- Silence (EDM)
loadstring(game:HttpGet("https://raw.githubusercontent.com/check78/Entities/main/SilenceEndless.txt"))()

-- Silence (HC)
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(450, 890))
			if not IsSeekChase or IsFigure or IsHalt or IsMines then
				LatestRoom.Changed:Wait()
				wait(2)
				loadstring(game:HttpGet("https://pastebin.com/raw/uNnkcsGU"))()
			end		
		end
	end
end)()

-- Hungered
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(693, 780))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/JPL5TUtW"))()
			end
		end
	end
end)()

-- Glitched Eyes
coroutine.wrap(function()
	while true do
		if not IsGlitched then
			wait(math.random(12, 30))
			local currentLoadedRoom = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
			local eyes = game:GetObjects("rbxassetid://71139650987794")[1]
			eyes.Name = "GlitchedEyes"

			local num = 0
			if currentLoadedRoom:FindFirstChild("PathfindNodes") then
				num = math.floor(#currentLoadedRoom.PathfindNodes:GetChildren() / 2)
			end

			eyes.Core.CFrame = ( 
				num == 0 and currentLoadedRoom[currentLoadedRoom.Name] or currentLoadedRoom.PathfindNodes[num]
			).CFrame + Vector3.new(0, 7, 0)

			eyes.Parent = currentLoadedRoom
			eyes.Anchored = true

			local initiateSound = eyes.Core:FindFirstChild("Initiate")
			local ambienceSound = eyes.Core:FindFirstChild("Ambience")
			if initiateSound then initiateSound:Play() end
			if ambienceSound then ambienceSound:Play() end

			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer

			while eyes.Parent do
				local character = LocalPlayer.Character
				local humanoid = character and character:FindFirstChild("Humanoid")
				if humanoid and humanoid.Health > 0 then
					local camera = workspace.CurrentCamera
					local _, onScreen = camera:WorldToScreenPoint(eyes.Core.Position)
					if onScreen then
						humanoid.Health -= 10
						local attackSound = eyes.Core:FindFirstChild("Attack")
						if attackSound then attackSound:Play() end
						if humanoid.Health <= 0 then
							game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Glitched Eyes"
							firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, 
								{"You died to a Eyes Variation", 
									"You can call it Glitched Eyes..", 
									"It can appear everywhere", 
									"Use what you learned with Eyes"}, 
								"Blue"
							)
						end	
					end
				end
			end

			while eyes.Parent do
				local oph = math.random(1, 35)
				if oph == 5 then
					local player = game:GetService("Players").LocalPlayer
					local characterRoot = player.Character.PrimaryPart
					if characterRoot then
						local randomOffset = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
						local newPosition = characterRoot.CFrame + randomOffset + Vector3.new(0, 7, 0)
						local CustomMusic = getGitSoundId("https://github.com/vct0721/Doors-Stuff/blob/main/EyesTeleport.mp3?raw=true", "TeleportEyes")
						CustomMusic.Parent = eyes.Core
						CustomMusic.Looped = false
						CustomMusic:Play()			
						eyes.Core.CFrame = CFrame.new(newPosition)
						CustomMusic.Ended:Wait()
						CustomMusic:Destroy()
					end
				end	
			end

			while eyes.Parent do
				task.wait(0.2)
				if currentLoadedRoom:FindFirstChild("GlitchedEyes") then
					game:GetService("TweenService"):Create(
						eyes.Core.Ambience,
						TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
						{ PlaybackSpeed = math.random(5, 15) / 10 }
					):Play()
				end
			end
		end
	end
end)()	

-- The Watcher
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(199, 390))
			if IsMines then
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					LatestRoom.Changed:Wait()
					wait(0)
					loadstring(game:HttpGet("https://pastefy.app/fQZmOOSq/raw"))()
				end
			end
		end
	end
end)()

-- A-25
coroutine.wrap(function()
	while true do
		if IsMines then
			wait(math.random(250, 490))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/6l2QHB8I/raw"))()
			end
		end
	end
end)()

-- Ripper
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(100, 210))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/jncKfAWe/raw"))()
			end
		end
	end
end)()

-- A-120
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm =  math.random(190, 350)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble or IsMines then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastefy.app/dh7c3tm0/raw"))()
			end
		end
	end
end)()

-- A-200
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm =  math.random(290, 450)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble or IsMines then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/S9KGv5Ce"))()
			end
		end
	end
end)()

-- TryHard Blitz
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm =  math.random(50, 250)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				loadstring(game:HttpGet("https://pastefy.app/XyEFOSsV/raw"))()
			end
		end
	end
end)()

-- Reversed Rush
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm =  math.random(50, 135)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				loadstring(game:HttpGet("https://pastefy.app/zSkdnWvF/raw"))()
			end
		end
	end
end)()

-- Matcher
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm =  math.random(50, 150)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/XzuW1A1p"))()
			end
		end
	end
end)()

-- Shocker 
coroutine.wrap(function()
	while true do
		wait(math.random(6,50))
		local Players = game:GetService("Players")
		local Workspace = game:GetService("Workspace")

		local player = Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")

		local function spawnShocker()
			local shockerModel = game:GetObjects("rbxassetid://11547803978")[1]
			shockerModel.PrimaryPart = shockerModel:FindFirstChild("HumanoidRootPart") or shockerModel:FindFirstChildWhichIsA("Part")

			local camera = Workspace.CurrentCamera
			shockerModel:SetPrimaryPartCFrame(camera.CFrame * CFrame.new(0, 0, -7))
			shockerModel.Parent = Workspace

			local oogaBoogaaPart = shockerModel:WaitForChild("OOGA BOOGAAAA")
			local horrorScream = shockerModel:WaitForChild("OOGA BOOGAAAA"):WaitForChild("HORROR SCREAM 15")

			local lookDuration = 4
			local startTime = tick()
			local playerLookingAtShocker = true

			while playerLookingAtShocker do
				wait(0.1)

				local angle = (oogaBoogaaPart.Position - character.PrimaryPart.Position).unit
				local direction = camera.CFrame.LookVector

				if (angle:Dot(direction) > 0.9) then
					if tick() - startTime >= lookDuration then
						horrorScream:Play()
						humanoid:TakeDamage(30)
						playerLookingAtShocker = false

						local speed = 10
						local targetPosition = character.PrimaryPart.Position

						while oogaBoogaaPart.Position.Y > targetPosition.Y do
							local directionToPlayer = (targetPosition - oogaBoogaaPart.Position).unit
							oogaBoogaaPart.Position = oogaBoogaaPart.Position + directionToPlayer * speed * 0.1
							wait(0.1)
						end

						oogaBoogaaPart.CanCollide = false
						oogaBoogaaPart.Anchored = false
						wait(3)
						shockerModel:Destroy()
						game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Shocker"
						firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"You died to who you call Shocker...","Dont look at it or it stuns you!."},"Blue")
						break
					end
				else

					oogaBoogaaPart.CanCollide = false
					oogaBoogaaPart.Anchored = false
					break
				end
			end
			oogaBoogaaPart.CanCollide = false
			oogaBoogaaPart.Anchored = false
			wait(3)
			shockerModel:Destroy()
			---====== Load achievement giver ======---
			local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

			---====== Display achievement ======---
			achievementGiver({
				Title = "Shocking Experience",
				Desc = "Look at me.",
				Reason = "Encounter Shocker.",
				Image = "rbxassetid://17857830685"
			})
		end
		spawnShocker()
	end
end)()  

-- Blinky

coroutine.wrap(function()

	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then

			wait(math.random(122, 268))

			LatestRoom.Changed:Wait()

			loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/blinkcrux"))()

		end

	end

end)()

-- Overseer Eyes
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(3,100))
			LatestRoom.Changed:Wait()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/Overseer.lua"))()
		end
	end

	-- No Overseer in Lever Room
	workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.ChildAdded:Connect(function(eye)
		if eye.Name == "LeverForGate" then
			wait(0.6)
			if workspace:FindFirstChild("Overseer") then
				workspace.Overseer:Destroy()
			end
		else

		end
	end)

	-- No Overseer in Seek Chase
	workspace.ChildAdded:Connect(function(seek)
		if seek.Name == "SeekMoving" or seek.Name == "SeekMovingNewClone" then
			wait(0.6)
			if workspace:FindFirstChild("Overseer") then
				workspace.Overseer:Destroy()
			end
		else

		end
	end)

	-- No Overseer and Normal Eyes Combo
	workspace.ChildAdded:Connect(function(seek)
		if seek.Name == "Eyes" then
			wait(0.6)
			if workspace:FindFirstChild("Overseer") then
				workspace.Overseer:Destroy()
			end
		else

		end
	end)	

end)()

-- Rebound
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			local sctm = math.random(236, 960)
			wait(sctm)
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/refs/heads/main/Rebound.lua"))()
			end
		end
	end
end)()

-- Smiler
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(1050, 2090))
			if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/rCTaWAqN"))()
			end
		end
	end
end)()

-- Common Sence
coroutine.wrap(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		if not IsRooms or IsMines or IsBackHotel then
			if roomValue == 50 then
				loadstring(game:HttpGet("https://pastefy.app/paHmzMzk/raw"))()		
			end
		end
	end)
end)()

-- Claim
coroutine.wrap(function()
	while true do
		if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
			wait(math.random(100, 550))
			if not IsSeekChase or IsFigure or IsHalt or IsMines then
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/d3R357Rk"))()
			end
		end
	end
end)()

-- Phill
coroutine.wrap(function()
	while true do
		wait(math.random(5, 2100))
		if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
			local spawn_chance = math.random(1, 1750)
			if spawn_chance == 1 then
				LatestRoom.Changed:Wait()
				require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('What just happened?!!!', true)
				loadstring(game:HttpGet("https://pastebin.com/raw/JLFyvnp2"))()
			end
		end
	end
end)()

-- Seek Eyes (Room 50)
coroutine.wrap(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		if game.ReplicatedStorage.GameData.LatestRoom.Value == 50 and (IsHotel or IsMines or IsBackHotel) then
			require(game.ReplicatedStorage.ClientModules.EntityModules.Seek).tease(nil, workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")], 100)
		end
	end)
end)()

-- Seek Eyes (Room 100)
coroutine.wrap(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		if game.ReplicatedStorage.GameData.LatestRoom.Value == 100 and (IsHotel or IsMines) then
			require(game.ReplicatedStorage.ClientModules.EntityModules.Seek).tease(nil, workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")], 100)
		end
	end)
end)()

-- Seek Eyes (Greenhouse)
coroutine.wrap(function()

	if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" or game:GetService("ReplicatedStorage").GameData.Floor.Value == "Fools" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			if game.ReplicatedStorage.GameData.LatestRoom.Value == 90 or game.ReplicatedStorage.GameData.LatestRoom.Value == 91 or game.ReplicatedStorage.GameData.LatestRoom.Value == 92 or game.ReplicatedStorage.GameData.LatestRoom.Value ==  93 or game.ReplicatedStorage.GameData.LatestRoom.Value == 94 or game.ReplicatedStorage.GameData.LatestRoom.Value == 95 or game.ReplicatedStorage.GameData.LatestRoom.Value == 96 or game.ReplicatedStorage.GameData.LatestRoom.Value == 97 then

				wait(3)

				local a = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game
				require(game.ReplicatedStorage.ClientModules.EntityModules.Seek).tease(nil, workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")], 100)

			end

		end)

	end

end)()

-- Victrola
coroutine.wrap(function()
	while true do
		wait(math.random(131, 300))
		LatestRoom.Changed:Wait()
		wait(0.5)
		local omg = Instance.new("Model")
		omg.Parent = workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]
		omg.Name = "Victrola"

		local currentLoadedRoom=workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
		local eyes = game:GetObjects("rbxassetid://166258731")[1]

		local num=0

		if currentLoadedRoom:FindFirstChild("Nodes") then
			num = math.floor(#currentLoadedRoom.Nodes:GetChildren()/2)
		end

		eyes.CFrame=(
			num==0 and currentLoadedRoom[currentLoadedRoom.Name] or currentLoadedRoom.Nodes[num]
		).CFrame + Vector3.new(0, 5, 0)

		eyes.Parent = workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Victrola
		eyes.Anchored = false
		local pirarie = Instance.new("Sound")
		pirarie.Parent = workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Victrola.Victrola
		pirarie.Name = "Music"
		pirarie.SoundId = "rbxassetid://1847452015"
		pirarie.Pitch = 0
		pirarie.Looped = true
		pirarie.RollOffMaxDistance = 10000
		pirarie.RollOffMinDistance = 10
		pirarie:Play()
		game:GetService("TweenService"):Create(pirarie,TweenInfo.new(6.7),{Pitch = 0.9}):Play()
	end
end)()

-- Damage's timer

coroutine.wrap(function()

	if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(number)

			local roommate = workspace.CurrentRooms[number]

			local Take_Damage = true

			if workspace.CurrentRooms == roommate then return end

			if Take_Damage then

				task.wait(0)

			elseif task.wait(370) then

				loadstring(game:HttpGet("https://pastebin.com/raw/ZLALF8Ce"))()

				return

			end

		end)

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Mines" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(number)

			local roommate = workspace.CurrentRooms[number]

			local Take_Damage = true

			if workspace.CurrentRooms == roommate then return end

			if Take_Damage then

				task.wait(0)

			elseif task.wait(5000) then

				loadstring(game:HttpGet("https://pastebin.com/raw/ZLALF8Ce"))()

				return

			end

		end)

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Backdoor" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(number)

			local roommate = workspace.CurrentRooms[number]

			local Take_Damage = true

			if workspace.CurrentRooms == roommate then return end

			if Take_Damage then

				task.wait(0)

			elseif task.wait(35) then

				loadstring(game:HttpGet("https://pastebin.com/raw/ZLALF8Ce"))()

				return

			end

		end)

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Rooms" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(number)

			local roommate = workspace.CurrentRooms[number]

			local Take_Damage = true

			if workspace.CurrentRooms == roommate then return end

			if Take_Damage then

				task.wait(0)

			elseif task.wait(235) then

				loadstring(game:HttpGet("https://pastebin.com/raw/ZLALF8Ce"))()

				return

			end

		end)

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Fools" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(number)

			local roommate = workspace.CurrentRooms[number]

			local Take_Damage = true

			if workspace.CurrentRooms == roommate then return end

			if Take_Damage then

				task.wait(0)

			elseif task.wait(105) then

				loadstring(game:HttpGet("https://pastebin.com/raw/ZLALF8Ce"))()

				return

			end

		end)

		--[[ ]]--

	end

end)()

-- Crucifix item in table

coroutine.wrap(function()

	if IsHotel then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "Cruxy" or cruxy.Sideroom.Name == "CruxyRoomy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "Table" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				elseif v.Name == "Table" and v.Parent.Name == "Sideroom" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

		end)

	elseif IsMines then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "Cruxy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "OldWoodenTable" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

		end)

	elseif IsBackHotel then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "Cruxy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "Backdoor_Table" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "CruxyRoomy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "Table" and v.Parent.Name == "Backdoor_Sideroom" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

		end)

	elseif IsRooms then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "Cruxy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "Table" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

		end)

	elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Fools" then

		game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

			function spawncruxy(posy)

				local abc = game:GetObjects("rbxassetid://13872336829")[1]

				local cruxy = abc.Handle:Clone()

				abc:Destroy()

				cruxy.Parent = game.Workspace

				cruxy.Name = "Cruxy"

				cruxy.Position = posy

				cruxy.Anchored = true

				local xy = math.random(-90, 90)

				cruxy.CFrame = CFrame.lookAt(cruxy.Position, cruxy.Position - Vector3.new(xy, yy, zy))

				cruxy.Rotation = Vector3.new(0, xy, 0)

				local prompty = Instance.new("ProximityPrompt")

				prompty.Name = "prompty"

				prompty.MaxActivationDistance = 5

				prompty.ObjectText = "Custom"

				prompty.RequiresLineOfSight = true

				prompty.Parent = cruxy

				prompty.Style = "Custom"

				prompty.Triggered:Connect(function()

					cruxy:Destroy()

					local shadow=game:GetObjects("rbxassetid://13872336829")[1]

					shadow.Parent = game.Players.LocalPlayer.Backpack

					local Players = game:GetService("Players")

					local Plr = Players.LocalPlayer

					local Char = Plr.Character or Plr.CharacterAdded:Wait()

					local Hum = Char:WaitForChild("Humanoid")

					local RightArm = Char:WaitForChild("RightUpperArm")

					local LeftArm = Char:WaitForChild("LeftUpperArm")

					local RightC1 = RightArm.RightShoulder.C1

					local LeftC1 = LeftArm.LeftShoulder.C1

					local function setupCrucifix(tool)

						RightArm.Name = "R_Arm"

						LeftArm.Name = "L_Arm"



						RightArm.RightShoulder.C1 = RightC1 * CFrame.Angles(math.rad(-90), math.rad(-15), 0)

						LeftArm.LeftShoulder.C1 = LeftC1 * CFrame.new(-0.2, -0.3, -0.5) * CFrame.Angles(math.rad(-125), math.rad(25), math.rad(25))

						for _, v in next, Hum:GetPlayingAnimationTracks() do

							v:Stop()

						end

					end

					shadow.Equipped:Connect(function()

						setupCrucifix(shadow)

						game.Players.LocalPlayer:SetAttribute("Hidden", true)

					end)



					shadow.Unequipped:Connect(function()

						game.Players.LocalPlayer:SetAttribute("Hidden", false)

						RightArm.Name = "RightUpperArm"

						LeftArm.Name = "LeftUpperArm"



						RightArm.RightShoulder.C1 = RightC1

						LeftArm.LeftShoulder.C1 = LeftC1

					end)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('You grabbed original crucifix',true)

					wait(3)

					require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption('This only works with custom entities',true)


				end)

				--

			end

			--



			local lastroom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value

			for _, v in next, game.Workspace.CurrentRooms[lastroom].Assets:GetDescendants() do

				if v.Name == "Table" then

					local randomy = math.random(1, 100)

					if randomy == 1 then

						local positio = v.Main.Position + Vector3.new(0, 2.5, 0)

						spawncruxy(positio)

					end

				end



			end

			--

		end)

		--[[ ]]--

	end

end)()

-- Entity Remixing

coroutine.wrap(function()

	loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/QOL/RushingFurtniture.lua"))()

	workspace.ChildAdded:Connect(function(inst)
		task.wait(1)

		if inst.Name == "RushMoving" and inst:FindFirstChild("RushNew") and inst.RushNew:FindFirstChild("Attachment") then
			LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Rush.ImageLabel.ImageColor3 = Color3.fromRGB(255, 0, 0)
			LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Rush.ImageLabelBig.ImageColor3 = Color3.fromRGB(255, 0, 0)
			inst.RushNew.PlaySound.PlaybackSpeed = 0.9
			inst.RushNew.Footsteps.PlaybackSpeed = 1.1
			local BlackTrail = inst.RushNew.Attachment.BlackTrail
			BlackTrail.Texture = "rbxassetid://16812282020"
			BlackTrail.Color = Color3.fromRGB(24, 29, 49)

			local BlackTrail2 = BlackTrail:Clone()
			BlackTrail2.Name = "BlackTrail2"
			BlackTrail2.Texture = "rbxassetid://16812299892"
			BlackTrail.Color = Color3.fromRGB(17, 20, 35)
			BlackTrail2.Parent = inst.RushNew.Attachment

			local BoolValue = Instance.new("BoolValue")
			BoolValue.Name = "Catalyst"
			BoolValue.Parent = inst

			inst.RushNew.Attachment.ParticleEmitter.Texture = "rbxassetid://16835616258"
			inst.RushNew.Attachment.ParticleEmitter.Brightness = 5

			repeat
				task.wait()
			until not inst:FindFirstChild("RushNew")

			if not inst:FindFirstChild("RushNew") then
				wait(0.5)
				local CeaseChance = math.random(1, 34)
				if CeaseChance == 1 or CeaseChance == 5 or CeaseChance == 10 then
					if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
						loadstring(game:HttpGet("https://pastefy.app/AaIrbcZS/raw"))()
					end
				end	
			end

		elseif inst.Name == "Eyes" and inst:FindFirstChild("Core") and inst.Core:FindFirstChild("Attachment") then

			game.Players.LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Eyes.BackgroundColor3 = Color3.fromRGB(255, 0, 55)


			inst.Core.Attachment.EyesParticle.Color = ColorSequence.new({

				ColorSequenceKeypoint.new(0, Color3.new(1, 0.305881, 0.305881)),

				ColorSequenceKeypoint.new(0.305881, Color3.new(1, 0.305881, 0.305881)),

				ColorSequenceKeypoint.new(0.305881, Color3.new(1, 0.305881, 0.305881)),

				ColorSequenceKeypoint.new(1, Color3.new(1, 0.305881, 0.305881)),

			})

			inst.Core.Ambience.PlaybackSpeed = 0.9

			repeat
				task.wait()
			until not inst:FindFirstChild("Core")

		elseif inst.Name == "AmbushMoving" and inst:FindFirstChild("RushNew") and inst.RushNew:FindFirstChild("Attachment") then
			LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Ambush.ImageLabel.ImageColor3 = Color3.fromRGB(255, 5, 50)		
			game.Workspace.AmbushMoving.Ambience.PlaybackSpeed = 1.1		
			game.Workspace.AmbushMoving.RushNew.PlaySound.PlaybackSpeed = 0.9
			game.Workspace.AmbushMoving.RushNew.Footsteps.PlaybackSpeed = 1.1
			local BoolValue = Instance.new("BoolValue")
			BoolValue.Name = "Catalyst"
			BoolValue.Parent = inst

			inst.RushNew.Attachment.ParticleEmitter.Texture = "rbxassetid://14985985638"
			inst.RushNew.Attachment.ParticleEmitter.Brightness = 1

			repeat
				task.wait()
			until not inst:FindFirstChild("RushNew")

		end
	end)
end)()

-- Insane Mines and Deep Hotel Intro
coroutine.wrap(function()
	game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
		if game.ReplicatedStorage.GameData.LatestRoom.Value == 52 then
			if IsMines then
				local CustomMusic = getGitSoundId("https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/refs/heads/main/Dark-Depths_Entrencebetter.mp3", "_IntroEntrance2")
				CustomMusic.Parent = game:GetService("SoundService")
				CustomMusic.Looped = false
				CustomMusic:Play()
				Lighting.Ambient = Color3.new(0, 0, 0)
				Lighting.Brightness = 0.1
				Lighting.FogEnd = 60
				Lighting.FogColor = Color3.new(0, 0, 0)
				local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
				local intro = shut:Clone()
				intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
				intro.Name = "_InsaneMinesIntro"
				intro.Visible = true
				intro.Text = "The Insane Mines"
				intro.TextTransparency = 0
				local underline = UDim2.new(1.1, 0, 0.015, 6)
				game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
				wait(7)
				game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
				wait(1)
				game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
				game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
				game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
				wait(2.3)
				intro.Visible = false
				CustomMusic.Ended:Wait()
				CustomMusic:Destroy()
				intro:Destroy()
				IsDeepHotel = false
				IsInsaneMines = true
			elseif IsHotel then
				local CustomMusic = getGitSoundId("https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/refs/heads/main/Dark-Depths_Entrencebetter.mp3", "_IntroEntrance1")
				CustomMusic.Parent = game:GetService("SoundService")
				CustomMusic.Looped = false
				CustomMusic:Play()
				Lighting.Ambient = Color3.new(0, 0, 0)
				Lighting.Brightness = 0.1
				Lighting.FogEnd = 60
				Lighting.FogColor = Color3.new(0, 0, 0)
				local shut = game.Players.LocalPlayer.PlayerGui.MainUI.MainFrame.IntroText
				local intro = shut:Clone()
				intro.Parent = game.Players.LocalPlayer.PlayerGui.MainUI
				intro.Name = "_DeepHotelIntro"
				intro.Visible = true
				intro.Text = "The Deep Hotel"
				intro.TextTransparency = 0
				local underline = UDim2.new(1.1, 0, 0.015, 6)
				game.TweenService:Create(intro.Underline, TweenInfo.new(3), {Size = underline}):Play()
				wait(7)
				game.TweenService:Create(intro.Underline, TweenInfo.new(1.3), {Size = UDim2.new(0.95, 0, 0.015, 6)}):Play()
				wait(1)
				game.TweenService:Create(intro.Underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
				game.TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()
				game.TweenService:Create(intro.Underline, TweenInfo.new(7), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
				wait(2.3)
				intro.Visible = false
				CustomMusic.Ended:Wait()
				CustomMusic:Destroy()
				intro:Destroy()
				IsInsaneMines = false
				IsDeepHotel = true
			end
		end
	end)
end)()   	

-- Insane Mines Setup

-- Lights Remove
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			wait(0.0005)
			RoomAssets.Chandelier:Destroy()
			RoomAssets.Light_Fixtures:Destroy()
		end
	end
end)()

-- A-90
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			wait(math.random(10, 29))
			if not IsSeekChase then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/K2TbsMWk/raw"))()
			end
		end
	end
end)()

-- B-60
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				wait(375)
				LatestRoom.Changed:Wait()
				loadstring(game:HttpGet("https://pastebin.com/raw/s2jHyGmm"))()
			end
		end
	end
end)()

-- A-10
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				wait(math.random(350, 590))
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					LatestRoom.Changed:Wait()
					wait(0)
					loadstring(game:HttpGet("https://pastefy.app/rmShikEK/raw"))()
				end
			end
		end
	end
end)()

-- Claim
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				wait(math.random(100, 550))
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					LatestRoom.Changed:Wait()
					loadstring(game:HttpGet("https://pastebin.com/raw/d3R357Rk"))()
				end
			end
		end
	end
end)()

-- Wh1t3 Remade
coroutine.wrap(function()
	while true do
		if IsInsaneMines then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					wait(math.random(500, 1390))
					LatestRoom.Changed:Wait()
					local cuew = Instance.new("Sound")
					cuew.Parent = game.Workspace
					cuew.Name = "Spawn"
					cuew.SoundId = "rbxassetid://3359047385"
					cuew.Volume = 1
					cuew.PlaybackSpeed = 1
					cuew:Play()
					game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(0, 255, 0)
					game.Lighting.MainColorCorrection.Contrast = 25
					local tween = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(9), {Contrast = 0})
					tween:Play()
					local TW = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(1), {TintColor = Color3.fromRGB(255, 255, 255)})
					TW:Play()
					loadstring(game:HttpGet("https://pastebin.com/raw/2LTckSaJ"))()
				end
			end
		end
	end
end)()

-- Deep Hotel Setup

-- Lights Remove
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			wait(0.0005)
			RoomAssets.Chandelier:Destroy()
			RoomAssets.Light_Fixtures:Destroy()
		end
	end
end)()

-- A-90
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			wait(math.random(10, 29))
			if not IsSeekChase then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://pastefy.app/K2TbsMWk/raw"))()
			end
		end
	end
end)()

-- Dread HC 
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			wait(math.random(29, 63))
			if not IsSeekChase or IsFigure or IsHalt then
				LatestRoom.Changed:Wait()
				wait(0)
				loadstring(game:HttpGet("https://raw.githubusercontent.com/huyhoanggphuc/Entity-obfuscate/refs/heads/main/Dread.lua"))()
			end
		end
	end	
end)()

-- Wh1t3 Remade
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					wait(math.random(500, 1390))
					LatestRoom.Changed:Wait()
					local cuew = Instance.new("Sound")
					cuew.Parent = game.Workspace
					cuew.Name = "Spawn"
					cuew.SoundId = "rbxassetid://3359047385"
					cuew.Volume = 1
					cuew.PlaybackSpeed = 1
					cuew:Play()
					game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(0, 255, 0)
					game.Lighting.MainColorCorrection.Contrast = 25
					local tween = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(9), {Contrast = 0})
					tween:Play()
					local TW = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(1), {TintColor = Color3.fromRGB(255, 255, 255)})
					TW:Play()
					loadstring(game:HttpGet("https://pastebin.com/raw/2LTckSaJ"))()
				end
			end
		end
	end
end)()

-- Surge
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				local sctm = math.random(900, 2970)
				wait(sctm)
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					LatestRoom.Changed:Wait()
					local cue2 = Instance.new("Sound")
					cue2.Parent = game.Workspace
					cue2.Name = "Spawn"
					cue2.SoundId = "rbxassetid://3359047385"
					cue2.Volume = 1
					cue2.PlaybackSpeed = 1
					cue2:Play()
					game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(0, 255, 0)
					game.Lighting.MainColorCorrection.Contrast = 25
					local tween = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(9), {Contrast = 0})
					tween:Play()
					local TW = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(1), {TintColor = Color3.fromRGB(255, 255, 255)})
					TW:Play()
					wait(1)
					loadstring(game:HttpGet("https://pastebin.com/raw/jTEPNkrV"))()
				end
			end
		end
	end
end)()

-- Monoxide
coroutine.wrap(function()
	while true do
		if IsDeepHotel then
			if not ((roomValue >= 48 and roomValue <= 55) or (roomValue >= 98 and roomValue <= 101)) then
				local sctm = math.random(400, 999)
				wait(sctm)
				if not IsSeekChase or IsFigure or IsHalt or IsGrumble then
					local cue2 = Instance.new("Sound")
					cue2.Parent = game.Workspace
					cue2.Name = "Spawn"
					cue2.SoundId = "rbxassetid://7053083974"
					cue2.Volume = 1
					cue2.PlaybackSpeed = 1
					cue2:Play()
					game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(0, 0, 255)
					game.Lighting.MainColorCorrection.Contrast = 10
					local tween = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(2.5), {Contrast = 0})
					tween:Play()
					local TW = game:GetService("TweenService"):Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)})
					TW:Play()
					wait(1.9)
					loadstring(game:HttpGet("https://pastebin.com/raw/pm2GUxHV"))()	
				end
			end
		end
	end
end)()					
