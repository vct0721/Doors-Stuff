-- Services
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

-- Variables
local module = {}

-- Functions
local function timestampToMillis(timestamp: string | number | DateTime)
    return (typeof(timestamp) == "string" and DateTime.fromIsoDate(timestamp).UnixTimestampMillis) or (typeof(timestamp) == "number" and timestamp) or timestamp.UnixTimestampMillis
end

module.LoadCustomAsset = function(url: string)
    if getcustomasset then
        if url:lower():sub(1, 4) == "http" then
            local fileName = `temp_{tick()}.txt`
            writefile(fileName, game:HttpGet(url))
            local result = getcustomasset(fileName, true)
            delfile(fileName)
            return result
        elseif isfile(url) then
            return getcustomasset(url, true)
        end
    else
        warn("Executor doesn't support 'getcustomasset', rbxassetid only.")
    end
    if url:find("rbxassetid") or tonumber(url) then
        return "rbxassetid://"..url:match("%d+")
    end
    error(debug.traceback("Failed to load custom asset for:\n"..url))
end

module.LoadCustomInstance = function(url: string)
    local success, result = pcall(function()
        return game:GetObjects(module.LoadCustomAsset(url))[1]
    end)
    if success then
        return result
    end
end

local function spawnEntity(config)
    local CustomEyeSpawnerConfig = config

    local function fadeOut(entity)
        for i = 0, 1, 0.1 do
            entity.Transparency = i
            task.wait(0.05)
        end
    end

    local function fadeIn(entity)
        for i = 1, 0, -0.1 do
            entity.Transparency = i
            task.wait(0.05)
        end
    end

    local function shouldTeleport()
        return math.random(1, 100) <= 10
    end

    wait(0.5)

    local enableDamage = true
    local currentLoadedRoom = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
    
    local CustomEntity = module.LoadCustomInstance(CustomEyeSpawnerConfig.Model)

    if CustomEntity then
        CustomEntity.Name = CustomEyeSpawnerConfig.CustomName
        CustomEntity:SetAttribute("Custom Entity", true)
        
        local num = math.floor(#currentLoadedRoom.PathfindNodes:GetChildren() / 2)
        CustomEntity.CFrame = (num == 0 and currentLoadedRoom.Base or currentLoadedRoom.PathfindNodes[num]).CFrame + Vector3.new(0, CustomEyeSpawnerConfig.HeightOffset, 0)
        CustomEntity.Parent = workspace

        print(CustomEntity.Name .. " has spawned at position: " .. tostring(CustomEntity.Position))

        local doorOpened = false
        local doorConnect

        doorConnect = workspace.CurrentRooms.ChildAdded:Connect(function()
            if CustomEntity and CustomEntity.Parent then
                CustomEntity:Destroy()
                print(CustomEntity.Name .. " has been destroyed due to door opening.")
            end
            enableDamage = false
            doorOpened = true
            doorConnect:Disconnect()
        end)

        local teleportCount = config.TeleportConfig.Forced and math.random(config.TeleportConfig.Min, config.TeleportConfig.Max) or 0

        if shouldTeleport() or teleportCount > 0 then
            wait(3)
            teleportCount = teleportCount > 0 and teleportCount or math.random(config.TeleportConfig.Min, config.TeleportConfig.Max)

            for i = 1, teleportCount do
                if not doorOpened and shouldTeleport() then
                    enableDamage = false
                    fadeOut(CustomEntity)

                    local nodes = currentLoadedRoom.PathfindNodes:GetChildren()
                    if #nodes > 0 then
                        local randomNode = nodes[math.random(1, #nodes)]
                        CustomEntity.CFrame = randomNode.CFrame + Vector3.new(0, config.HeightOffset, 0)
                        print(CustomEntity.Name .. " has teleported to: " .. tostring(CustomEntity.Position))
                    end

                    fadeIn(CustomEntity)
                    wait(0.5)
                    enableDamage = true
                end
            end
        end

        local player = game:GetService("Players").LocalPlayer
        local hum = player.Character:FindFirstChildOfClass("Humanoid")

        while enableDamage and hum and hum.Health > 0 do
            if not CustomEntity or not CustomEntity.Parent then break end

            local _, found = workspace.CurrentCamera:WorldToScreenPoint(CustomEntity.Position)

            if config.DamageConfig.DamageOnNotLooking and not found then
                hum.Health = hum.Health - config.DamageConfig.DamageAmount
                print(hum.Parent.Name .. " took damage for not looking. Health: " .. hum.Health)
            end

            if config.DamageConfig.DamageOnLook and found then
                hum.Health = hum.Health - config.DamageConfig.DamageAmount
                print(hum.Parent.Name .. " took damage for looking. Health: " .. hum.Health)
            end

            if config.KillRangeConfig.IsEnabled and (hum.Parent.PrimaryPart.Position - CustomEntity.Position).magnitude <= config.KillRangeConfig.Range then
                if config.DamageConfig.DamageOnEntitySeeing then
                    hum.Health = hum.Health - config.DamageConfig.DamageAmount
                    print(hum.Parent.Name .. " took damage because the entity saw them. Health: " .. hum.Health)
                end
            end

            if hum.Health <= 0 then
                game:GetService("ReplicatedStorage").GameStats["Player_" .. player.Name].Total.DeathCause.Value = config.DeathConfig.Cause
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, config.DeathConfig.Hints, config.DeathConfig.Type)
                print(hum.Parent.Name .. " has died. Cause: " .. config.DeathConfig.Cause)
            end

            task.wait(0.5)
        end

        if hum.Health <= 0 and CustomEntity then
            CustomEntity:Destroy()
        end
    end
end

return {
    spawnEntity = spawnEntity,
    CustomEyeSpawnerConfig = CustomEyeSpawnerConfig,
}
