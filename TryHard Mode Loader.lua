-- Verify if the game mode is executed before door 1
if game.ReplicatedStorage.GameData.LatestRoom.Value > 0 then
    -- If the script is loaded after door 0, the player will be killed
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You need to load the mode before door 1!", true)
    firesignal(game.ReplicatedStorage.Bricks.DeathHint.OnClientEvent, {"Load the mode before door 1!", "You will be killed because you didn't load the mode on time."})
    game.ReplicatedStorage.GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Did not load before door 1"
    return
end

-- If door is 0, execute the game mode
loadstring(game:HttpGet("https://pastebin.com/raw/Zwpaw3fu"))()
