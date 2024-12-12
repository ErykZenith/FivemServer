game_player = {}
game_player.__index = game_player
client_player = {}

local function setupPlayer(
    position,
    health,
    armor
)
    print("[^2INFO^7] setupPlayer ^5")
    spawnPlayer(position)
    local pedId = PlayerPedId()
    if health > GetEntityMaxHealth(pedId) then
        health = GetEntityMaxHealth(pedId)
    end
    SetEntityHealth(pedId, health)
    if armor > 100 then
        armor = 100
    end
    SetPedArmour(pedId, armor)
end

function game_player:initializePlayerData(
    position,
    health,
    armor,
    money
)
    print("[^2INFO^7] initializePlayerData ^5")
    local instance = setmetatable({}, game_player)
    instance.money = money
    
    setupPlayer(position, health, armor)
    return instance
end