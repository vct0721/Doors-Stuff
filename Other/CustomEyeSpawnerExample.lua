local spawner

local CustomEyeSpawnerConfig = { 
    CustomName = "Custom Multiple Eyes Entity",
    Model = "rbxassetid://12285389022",
    DelayTime = 1,
    HeightOffset = 5,
    CanKill = true,

    DamageConfig = {
        DamageAmount = 15,
        DamageOnLook = true,
        DamageOnNotLooking = false,
        DamageOnEntitySeeing = true,
    },

    KillRangeConfig = {
        IsEnabled = true,
        Range = 25,
    },

    TeleportConfig = {
        Forced = true,
        Min = 2,
        Max = 5,
    },

    DeathConfig = { 
        Type = "Red",
        Hints = {
            "You should have looked away...", 
            "Too bad you didn't see that coming!", 
            "What a way to go!", 
            "Next time, don't stare.", 
            "The eyes are always watching.", 
            "Maybe look away next time?", 
            "Surprise! You are not alone."
        },
        Cause = "Custom Eyes"
    }
}

-- Executa a função com a configuração modificada
spawnEntity(CustomEyeSpawnerConfig)