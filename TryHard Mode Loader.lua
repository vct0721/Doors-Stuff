if game.ReplicatedStorage.GameData.LatestRoom.Value > 0 or game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then 
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You need to load the mode before door 1 and you need to be alive!", true)
    wait(0.2)
    game.Players.LocalPlayer.Character.Humanoid.Health = -100
    game.ReplicatedStorage.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Did not load before door 1"
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/refs/heads/main/Try%20Hard%20Mode.lua"))()
end
