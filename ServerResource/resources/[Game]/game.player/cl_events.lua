local function initializePlayerData(...)
    print("[^2INFO^7] event > game.player/initializPlayerData ^5"..json.encode({...}).."^7")
    client_player = game_player:initializePlayerData(...)
end
RegisterNetEvent("game.player/initializePlayerData", initializePlayerData)

local function updateTransaction(amount)
    client_player.money = amount
end
RegisterNetEvent("game.player/update/transaction", updateTransaction)