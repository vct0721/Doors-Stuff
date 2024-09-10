if game.ReplicatedStorage.GameData.LatestRoom.Value > 0 or game.Players.LocalPlayer.Character.Humanoid.Health < 1 then
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You need to load the mode before door 1 and you need to be alive!", true)
	wait(1)
	game.Players.LocalPlayer.Character.Humanoid.Health = -100
    game.ReplicatedStorage.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Did not load before door 1"
	
end

if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Retro" then

game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

game.Players.LocalPlayer:Kick("Shoutout for hacking HC Remake")	

elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/Try%20Hard%20Mode"))()

elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Mines" then 
loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/TryHard%20Floor%202"))()

elseif game.ReplicatedStorage.GameData.Floor.Value == Rooms then
loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/Try%20Hard%20Mode"))()

elseif game.ReplicatedStorage.GameData.Floor.Value == Backdoor then
loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/Try%20Hard%20Mode"))()

