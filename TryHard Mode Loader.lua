-- Check if the mode is being loaded at door 0
game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
    local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

    -- If the door is not 0, kill the player
    if currentRoom > 1 then
        -- Error message or warning for the player
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Mode must be loaded at door 0! You have passed door 0, the game will be terminated.",
            Color = Color3.fromRGB(255, 0, 0),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18,
        })

        -- Set the cause of death (optional)
        game.ReplicatedStorage.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Mode loaded after door 0"

        -- Kill the player
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    else
        -- Execute TryHard v2 mode
        loadstring(game:HttpGet("https://pastebin.com/raw/Zwpaw3fu"))()
    end
end)
