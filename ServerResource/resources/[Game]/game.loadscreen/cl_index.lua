AddEventHandler("game.player/spawned", function()
    FreezeEntityPosition(GetPlayerPed(-1), true)
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Wait(0)
    end
    Wait(3000)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ShutdownLoadingScreenNui()
end)