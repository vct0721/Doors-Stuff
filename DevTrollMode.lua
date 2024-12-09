-- DevsTrollMode
if game.ReplicatedStorage.GameData.LatestRoom.Value > 0 or game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then 
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You need to load the mode before door 1 and you need to be alive!", true)
    wait(1)
    game.Players.LocalPlayer.Character.Humanoid.Health = -100
    game.ReplicatedStorage.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Did not load before door 1"
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if game:GetService("ReplicatedStorage"):FindFirstChild("TryHarder") then
    return warn("You have Already Loaded")
end

local Test = Instance.new("Part")
Test.Name = "TryHarder"
Test.Parent = game:GetService("ReplicatedStorage")
Test = 1

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("DevTroll Mode script succesfully executed (version 1)",true)

LatestRoom:GetPropertyChangedSignal("Value"):Wait()

-- High Speed 
coroutine.wrap(function()
	while true do
	   wait(math.random(math.random(1, 30), math.random(1, 30)))
	  LocalPlayer.Character:SetAttribute("SpeedBoost" , 25)
	  wait(math.random(10, 25))
	  LocalPlayer.Character:SetAttribute("SpeedBoost" , 0)
	end
end)()	 

-- Dreadfestation (OG Dread)
coroutine.wrap(function()
	while true do
			wait(math.random(80, 130))
				spawn(function()
					require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Dread)(require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
				end)
				repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.DreadVignette.Visible == true
				wait(1)
				repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainUI.MainFrame.DreadVignette.ImageColor3 ~= Color3.fromRGB(0,0,0) or not workspace:FindFirstChild('Dread')
				if not workspace:FindFirstChild("Dread") then
					return
				end
				game:GetService("ReplicatedStorage") .GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Dread"
				spawn(function()
					require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscares.Dread) (require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
				end)
				wait(1)
				pcall(function()
					firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"Uhhh", "Alright"}, "Blue")
				end)
				wait(1)
				game.Players.LocalPlayer.Character.Humanoid:TakeDamage(LocalPlayer.Character.Humanoid.Health)
	end
end)()

-- Trollface
coroutine.wrap(function()
	while true do
	   wait(math.random(math.random(1, 30), math.random(1, 30)))
	   
---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Trollface",
		Asset = "rbxassetid://18853391586",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = false,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 253,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = math.random(1, 3),
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = false,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Uhhh", "Alright"},
		Cause = "Trollface"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()

	end
end)()

--Giggles
coroutine.wrap(function()
	while true do
	   wait(math.random(math.random(2, 5), math.random(2, 5)))
	   
			getgenv().GIGGLE_SPAWN_CONFIG = {
				Damage = 6,
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
end)()  

--Bald Kreek
coroutine.wrap(function()
	while true do
	   wait(math.random(math.random(2, 20), math.random(2, 20)))
	   
---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "BaldKreek",
		Asset = "rbxassetid://12692082084",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = false,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 252,
		Delay = 2,
		Reversed = true
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = math.random(1, 2),
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = false,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Uhhh", "Alright"},
		Cause = "BaldKreek"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()

   end
end)()  

-- A-90
coroutine.wrap(function()
	while true do
	   wait(math.random(3, 10))
	   
local A90Module = UI.Initiator.Main_Game.RemoteListener.Modules.A90
local MainGame = require(UI.Initiator.Main_Game)
spawn(function()
require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90)(require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
end)
spawn(function()
wait(2)
Survived = true
end)
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_A90.FaceAngry.Visible == true or Survived
if Survived then return end
local ReSt = game:GetService("ReplicatedStorage") 
 ReSt.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "A-90"
 pcall(function()
  firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"Uhhh","Alright"},"Blue")
end)
wait(1)
game.Players.LocalPlayer.Character.Humanoid:TakeDamage(100)
	   
    end
end)()	

-- A-60
coroutine.wrap(function()
	while true do
	   wait(math.random(math.random(10, 20), math.random(15, 20)))
	   
	   ---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "A-60",
		Asset = "rbxassetid://11645649719",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 210,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 12,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = false,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Uhhh", "Alright"},
		Cause = "Ambush"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
	   
    end
end)()	

-- Ambush
coroutine.wrap(function()
	while true do
	   wait(math.random(20, 50))
	   
	   ---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Ambush",
		Asset = "rbxassetid://11884370026",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 200,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 12,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Uhhh", "Alright"},
		Cause = "Ambush"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
	   
    end
end)()	

-- Rush
coroutine.wrap(function()
	while true do
	   wait(math.random(10, 15))
	   
	   ---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Rush",
		Asset = "rbxassetid://11564808949",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 100,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 1,
		Delay = 2
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"Uhhh", "Alright"},
		Cause = "Rush"
	}
})

---====== Debug entity ======---

entity:SetCallback("OnSpawned", function()
    print("Entity has spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("Entity has started moving")
end)

entity:SetCallback("OnEnterRoom", function(room, firstTime)
    if firstTime == true then
        print("Entity has entered room: ".. room.Name.. " for the first time")
    else
        print("Entity has entered room: ".. room.Name.. " again")
    end
end)

entity:SetCallback("OnLookAt", function(lineOfSight)
	if lineOfSight == true then
		print("Player is looking at entity")
	else
		print("Player view is obstructed by something")
	end
end)

entity:SetCallback("OnRebounding", function(startOfRebound)
    if startOfRebound == true then
        print("Entity has started rebounding")
	else
        print("Entity has finished rebounding")
	end
end)

entity:SetCallback("OnDespawning", function()
    print("Entity is despawning")
end)

entity:SetCallback("OnDespawned", function()
    print("Entity has despawned")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		print("Entity has killed the player")
	else
		print("Entity has damaged the player")
	end
end)

--[[

DEVELOPER NOTE:
By overwriting 'CrucifixionOverwrite' the default crucifixion callback will be replaced with your custom callback.

entity:SetCallback("CrucifixionOverwrite", function()
    print("Custom crucifixion callback")
end)

]]--

---====== Run entity ======---

entity:Run()
	   
    end
end)()	   
