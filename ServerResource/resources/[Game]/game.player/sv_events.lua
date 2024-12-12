local function onPlayerDropped()
    local playerId = source
    print("[^2INFO^7] event > playerDropped ^5"..playerId.."^7")
    savePlayer(playerId)
    if game_player.server_players_data[playerId] then
        local license = game_player.server_players_data[playerId].license
        game_player.server_players_online[license] = nil
    end
    if game_player.server_players_data[playerId] then
        game_player.server_players_data[playerId] = nil
    end
end
AddEventHandler('playerDropped', onPlayerDropped)

local function onPlayerJoin()
    local playerId = source
    local player = game_player:initializePlayerData(playerId)
    game_player.server_players_data[playerId] = player
    print("[^2INFO^7] event > game.player/onPlayerJoin ^5"..player.license.."^7")
end
RegisterNetEvent("game.player/onPlayerJoin", onPlayerJoin)