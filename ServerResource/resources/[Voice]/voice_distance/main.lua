color = {}
color[1] = {r=143, g=255, b=75}
color[2] = {r=75, g=203, b=255}
color[3] = {r=255, g=75, b=149}
alpha = 150
delay = 0
delayTime = 500
seccess = nil
AddEventHandler('pma-voice:setTalkingMode', function(mode)
    seccess = true
    Wait(0)
    VoiceDistance(mode)
end)
function VoiceDistance(mode)
    local distance = Cfg.voiceModes[mode][1]
    local r,g,b,a = color[mode].r, color[mode].g, color[mode].b, alpha
    seccess = false
    delay = delayTime
    while not seccess do
        DrawMarker(1, GetEntityCoords(PlayerPedId())+vector3(0,0,0), 0.0,0.0,0.0, 0.0,0.0,0.0, distance,distance,0.125, r,g,b,math.floor((delay*a)/delayTime), false,true,2,nil,nil,false)
        DrawMarker(1, GetEntityCoords(PlayerPedId())+vector3(0,0,0.025), 0.0,0.0,0.0, 0.0,0.0,0.0, distance,distance,-0.125, r,g,b,math.floor((delay*a)/delayTime), false,true,2,nil,nil,false)
        Wait(0)
        delay = delay-10
        if delay <= 0 then
            seccess = true
        end
    end
end
