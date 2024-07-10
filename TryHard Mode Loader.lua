if game.ReplicatedStorage.GameData.LatestRoom.Value == 0 then

loadstring(game:HttpGet("https://pastebin.com/raw/Zwpaw3fu"))()

else then

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("TryHard mode script Not executed",true)

wait(1)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Execute The Script In Door 0")

---====== Load achievement giver ======---
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

---====== Display achievement ======---
achievementGiver({
    Title = "Wrong Room",
    Desc = "TryHard Mode not Executed",
    Reason = "Tryhard Mode Need To Be Executed In Door 0 Of The Floor",
    Image = "rbxassetid://12725627723"
})
