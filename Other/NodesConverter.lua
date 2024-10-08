-- NodeConverter.lua

local CurrentRooms = workspace:WaitForChild("CurrentRooms")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LatestRoom = ReplicatedStorage.GameData.LatestRoom

local function convertToLegacy(Room: Model): ()
    if Room:HasTag("Converted") then
        return
    end

    local PathfindNodes = Room:WaitForChild("PathfindNodes", 10)

    if not PathfindNodes then
        warn("PathfindNodes not found in room: " .. Room.Name)
        return
    end

    -- Create a list of new names for the clones
    local newNames = {"Nodes", "PathfindNodes", "PathNodes"}

    -- Clone the PathfindNodes for each new name
    for _, newName in ipairs(newNames) do
        local clone = PathfindNodes:Clone()
        clone.Name = newName
        clone.Parent = Room
    end

    -- Tag the room as converted
    Room:AddTag("Converted")

    if _G.DEBUG_HOTELPLUSPLUS then
        warn("Converted PathfindNodes to Nodes, PathfindNodes, and PathNodes in room: " .. Room.Name)
    end
end

-- Function to handle when the LatestRoom changes
local function onLatestRoomChanged()
    local roomName = tostring(LatestRoom.Value) -- Get the name of the latest room
    local LatestRoomModel = CurrentRooms:FindFirstChild(roomName)

    if LatestRoomModel then
        convertToLegacy(LatestRoomModel) -- Convert the latest room if it exists
    else
        warn("Latest room model not found: " .. roomName)
    end
end

-- Connect the LatestRoom change event
LatestRoom.Changed:Connect(onLatestRoomChanged)

-- Initial check for rooms already in CurrentRooms
for _, Room in ipairs(CurrentRooms:GetChildren()) do
    convertToLegacy(Room)
end
