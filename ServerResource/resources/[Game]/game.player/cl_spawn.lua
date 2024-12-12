
local function setPlayerLoad(playerId, action)
    local pedId = GetPlayerPed(playerId)
    SetPlayerControl(playerId, not action, false)
    SetEntityVisible(pedId, not action)
    SetEntityCollision(pedId, not action)
    FreezeEntityPosition(pedId, action)
    SetPlayerInvincible(playerId, action)
    if not IsPedFatallyInjured(pedId) then
        ClearPedTasksImmediately(pedId)
    end
end

function spawnPlayer(position)
    print("[^2INFO^7] spawnPlayer ^5")  
    local playerId = PlayerId()
    setPlayerLoad(playerId, true)
    local model_hash = GetHashKey("csb_rashcosvki")
    RequestModel(model_hash)
    while not HasModelLoaded(model_hash) do
        RequestModel(model_hash)
        Wait(0)
    end
    SetPlayerModel(playerId, model_hash)
    SetModelAsNoLongerNeeded(model_hash)
    if N_0x283978a15512b2fe then
        N_0x283978a15512b2fe(PlayerPedId(), true)
    end
    RequestCollisionAtCoord(position[1], position[2], position[3])
    local pedId = PlayerPedId()
    SetEntityCoordsNoOffset(pedId, position[1], position[2], position[3], false, false, false, false)
    NetworkResurrectLocalPlayer(position[1], position[2], position[3], 0.0, true, true, false)
    ClearPedTasksImmediately(pedId)
    RemoveAllPedWeapons(pedId)
    ClearPlayerWantedLevel(playerId)
    SetPlayerHealthRechargeMultiplier(playerId, 0.0)
    local time = GetGameTimer()
    while not HasCollisionLoadedAroundEntity(pedId) and (GetGameTimer() - time) < 5000 do
        Wait(0)
    end
    setPlayerLoad(playerId, false)
    ShutdownLoadingScreen()
    TriggerEvent("game.player/spawned")
end

CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            print("[^2INFO^7] requesting join...")
            TriggerServerEvent("game.player/onPlayerJoin")
            break
        end
        Wait(100)
    end
end)