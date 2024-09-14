if game.ReplicatedStorage.GameData.LatestRoom.Value > 0 or game.Players.LocalPlayer.Character.Humanoid.Health < 1 then
    game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.caption("You need to load the mode before door 1 and you need to be alive!", true)
    wait(1)
    game.Players.LocalPlayer.Character.Humanoid.Health = -999
    game.ReplicatedStorage.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Did not load before door 1"
end

if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Retro" then
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        game.Players.LocalPlayer:Kick("No More Retro Mode")
    end)
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/Try%20Hard%20Mode"))()
    wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vct0721/Doors-Stuff/main/Hard%20Modifiers"))()
end
