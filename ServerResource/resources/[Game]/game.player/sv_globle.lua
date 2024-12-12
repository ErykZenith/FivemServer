local function generateSQL(data)
    local setParts = {}
    local selectParts = {}
    for i=1, #data do
        local key = data[i]
        table.insert(setParts, "`" .. key .. "` = ?")
        table.insert(selectParts, "`" .. key .. "`")
    end
    local sql_update = table.concat(setParts, ", ")
    local sql_select = table.concat(selectParts, ", ")
    return sql_update, sql_select
end
sql_update, sql_select = generateSQL({
    "position",
    "health",
    "armor",
    "money",
})

function getLicense(playerId)
    local playerIdents = GetPlayerIdentifiers(playerId)
    local result = false
    for i = 1, #playerIdents do
        local license = playerIdents[i]
        if string.find(license, "steam") then
            result = string.gsub(license, "steam:", "")
            break
        end
    end
    return result
end

function savePlayer(playerId)
    local player = game_player.server_players_data[playerId]
    if not player then return end
    print("[^2INFO^7] savePlayer ^5", playerId,"|",player.license,"^7")
    local pedId = GetPlayerPed(playerId)
    local coords = GetEntityCoords(pedId)
    local affectedRows = MySQL.update.await("UPDATE players SET "..sql_update.." WHERE license = ?", {
        json.encode({
            tonumber(string.format("%.2f", coords.x)),
            tonumber(string.format("%.2f", coords.y)),
            tonumber(string.format("%.2f", coords.z))
        }),
        GetEntityHealth(pedId),
        GetPedArmour(pedId),
        player.money,
        player.license
    })
    return affectedRows > 0
end

function savePlayers()
    for license, playerId in pairs(game_player.server_players_online or {}) do
        savePlayer(playerId)
    end
end