local function syncGameTimeAndWeather(hours, minutes, seconds)
    local pause = false
    local hours, minutes, seconds = hours, minutes, seconds
    while true do
        Wait(1000)
        seconds = seconds + 1
        if seconds >= 60 then
            seconds = 0
            minutes = minutes + 1
        end
        if minutes >= 60 then
            minutes = 0
            hours = hours + 1
        end
        if hours >= 24 then
            hours = 0
        end
        if not pause then
            NetworkOverrideClockTime(hours, minutes, seconds)
            local weather = GlobalState.currentWeather or "CLEAR"
            SetWeatherTypePersist(weather)
            SetWeatherTypeNow(weather)
            SetWeatherTypeNowPersist(weather)
            weather = nil
        end
    end
    exports("switchSyncGameTimeAndWeather", function()
        pause = not pause
        return pause
    end)
end
RegisterNetEvent("game.world/syncGameTimeAndWeather", syncGameTimeAndWeather)
