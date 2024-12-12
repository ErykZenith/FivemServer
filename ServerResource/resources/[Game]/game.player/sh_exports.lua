database_exports = {}
if IsDuplicityVersion() then
    function database_exports.savePlayer(playerId)
        if not game_player.server_players_data[playerId] then 
            return print("[^1ERROR^7] Player with player ID " .. playerId .. " not found.")
        end
        return savePlayer(playerId)
    end
    
    function database_exports.updateTransaction(playerId, amount)
        local player = game_player.server_players_data[playerId]
        if not player then 
            print("[^1ERROR^7] Player with player ID " .. playerId .. " not found.")
            return false
        end
        player.money = math.max(0, math.floor(player.money + amount))
        TriggerClientEvent("game.player/update/transaction", playerId, player.money)
        return true
    end
    
    function database_exports.getPlayerData(playerId, action)
        local result = false
        if action then
            result = game_player.server_players_data[playerId][action] or result
        else
            result = game_player.server_players_data[playerId]
        end
        return result
    end
else
    function database_exports.getPlayerData(action)
        local result = false
        if action then
            result = client_player[action] or result
        else
            result = client_player
        end
        return result
    end
end

CreateThread(function()
    print("[^2INFO^7] Loading exports...")
    for name, fn in pairs(database_exports) do
        print("[^2INFO^7] Registering export: " .. name)
        if type(fn) == "function" then
            exports(name, fn)
        end
    end
    database_exports = nil
end)