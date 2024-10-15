-- MischeviousLight Edited
-- [Comet Development] By Chrono
-- This Is Part of the TryHard Mode By victor072134     
-- This is a edited part of the Hotel ++ Project By Chrono
--+Credits to Chrono and Dripo for the original script

_G.DO_RED_GUY = true -- enabled for debugging purposes only.

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local Camera = workspace.CurrentCamera
local DeathName = "DeathBackgroundBlue"

local RedPrimary = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(231, 131, 131)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(207, 84, 84))
})

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local MainUI = PlayerGui.MainUI
local Death = MainUI.Death
local HelpfulDialogue = Death.HelpfulDialogue
local MainGame = MainUI.Initiator.Main_Game
local Health = MainGame.Health
local Music = Health.Music

local initialHints = {
    "Hm...", 
    "Hello, I suppose we haven't met before", 
    "\"Where's Guiding and the Other guy?\" Well, they were... \"substituted\" for now", 
    "Anyways.."
}
local lastHint = "I'll be seeing you again."

-- Demotivational phrases  
local demotivatingPhrases = {
    "The light you seek is beyond your reach.",
    "You will never escape your fate.",
    "Hope is merely an illusion.",
    "You are destined to fail.",
    "Your time is running out; you have no way back.",
    "The light that shines is just a trap.",
    "Every path you take leads to darkness.",
    "You thought you could hide, but despair finds you.",
    "Your choices are meaningless in the end.",
    "The shadows will always be your companion.",
    "No one is coming to save you.",
    "This is where your journey ends."
}

local function getGitSoundId(GithubSoundPath: string, AssetName: string): Sound
    local Url = GithubSoundPath

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(Url)) 
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = getcustomasset(AssetName..".mp3", true)
    return Sound 
end

local function injectLastHint()
    local function ensureComma(hints)
        if #hints > 0 then
            local penultimateHint = hints[#hints]
            if not penultimateHint:match(",%s*$") then
                hints[#hints] = penultimateHint .. ","
            end
        end
    end

    local function modifyDeathHint(hints, type)
        -- Change type "Yellow" to "Blue"
        if type == "Yellow" then
            type = "Blue"
        end
        
        ensureComma(hints)
        
        -- Add a random demotivational phrase
        local randomIndex = math.random(1, #demotivatingPhrases)
        local demotivatingPhrase = demotivatingPhrases[randomIndex]
        table.insert(hints, demotivatingPhrase)

        -- Add the last hint
        if hints[#hints] ~= lastHint then
            table.insert(hints, lastHint)
        end

        -- Only accepts "Blue"
        if type ~= "Blue" then
            warn("Invalid Mischievous light type provided. Defaulting to 'Blue'.")
            type = "Blue"
        end

        -- Fire the event with the modified hints
        firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, hints, type)
    end

    local originalFiresignal = firesignal
    firesignal = function(event, hints, type)
        if event == game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent then
            modifyDeathHint(hints, type)
        else
            originalFiresignal(event, hints, type)
        end
    end

    -- Add initial hints, except the second one if already activated
    local hints = initialHints
    for i, hint in ipairs(initialHints) do
        if hint ~= "Hello, I suppose we haven't met before" or (i == 2 and not _G.secondHintActivated) then
            table.insert(hints, hint)
            if i == 2 then _G.secondHintActivated = true end -- Marks that the second hint has been activated
        end
    end
end

Camera.ChildAdded:Connect(
    function(Child: Instance)
        if Child.Name ~= DeathName then
            return
        end

        if not _G.DO_RED_GUY then
            return
        end

        -- Clear existing sounds
        for _, Asset in Music:GetChildren() do
            if Asset:IsA("Sound") then
                Asset:Destroy() -- lazy 
            end
        end

        local Lights = Child.Lights
        local Fog = Child.FogAndSmaller
        local Water = Child.Water

        for _, Light in Lights:GetDescendants() do
            if Light:IsA("SpotLight") then
                Light.Color = Color3.fromRGB(255, 130, 130)
            end

            if Light:IsA("ParticleEmitter") then
                Light.Color = RedPrimary
            end
        end

        for _, FogL in Fog:GetChildren() do
            FogL.Color = RedPrimary
        end

        for _, WaterL in Water:GetChildren() do
            WaterL.Color = RedPrimary
        end

        local BigLight = Lights.BigLight
        local Attachment = BigLight.Attachment
        local Moon = Attachment.Moon
        Moon.Texture = "rbxassetid://104807748100121"
        HelpfulDialogue.TextColor3 = Color3.fromRGB(255, 0, 0)

        local CustomMusic = getGitSoundId("https://raw.githubusercontent.com/ChronoAcceleration/Hotel-Plus-Plus/refs/heads/main/Assets/MischeviousLight.mp3", "MischeviousLight")
        CustomMusic.Parent = SoundService
        CustomMusic.Looped = true
        CustomMusic:Play()

        injectLastHint() -- Call the function to inject hints
    end
)
