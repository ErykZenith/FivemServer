local function onPlayerJoin()
    local playerId = source
    local time = os.date("*t")
    TriggerClientEvent("game.world/syncGameTimeAndWeather", playerId, time.hour, time.min, time.sec)
    playerId = nil
    time = nil
end
RegisterNetEvent("game.player/onPlayerJoin", onPlayerJoin)