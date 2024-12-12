game_player = {}
game_player.__index = game_player
game_player.server_players_data = {}
game_player.server_players_online = {}

function game_player:initializePlayerData(playerId)
    local license = getLicense(playerId)
    local players_online = game_player.server_players_online
    if not license then
        return DropPlayer("Your Steam ID is invalid.");
    end
    if players_online[license] then
        return DropPlayer(playerId, "Your Steam ID is already in use.")
    end
    local is_player = MySQL.scalar.await("SELECT 1 FROM players WHERE license = ?", { license })
    local instance = setmetatable({}, game_player)
    if not is_player then
        MySQL.insert('INSERT INTO players (license) VALUES (?)', {license})
    end
    local result = MySQL.prepare.await("SELECT "..sql_select.." FROM `players` WHERE license = ?", { license })
        
    print("[^2INFO^7] initializePlayerData ^5"..json.encode(result).."^7")

    instance.license = license
    instance.money = result.money

    TriggerLatentClientEvent("game.player/initializePlayerData", playerId, 100, 
        json.decode(result.position),
        result.health,
        result.armor,
        instance.money
    )

    players_online[license] = playerId
    return instance
end