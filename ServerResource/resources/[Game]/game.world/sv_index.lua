local function getSeasonalWeather()
    local currentMonth = tonumber(os.date("%m"))
    if currentMonth >= 3 and currentMonth <= 5 then
        selectedWeather = math.random() < 0.5 and 'RAIN' or 'OVERCAST'
    elseif currentMonth >= 6 and currentMonth <= 8 then
        selectedWeather = math.random() < 0.7 and 'EXTRASUNNY' or 'CLEAR'
    elseif currentMonth >= 9 and currentMonth <= 11 then
        selectedWeather = math.random() < 0.5 and 'OVERCAST' or 'SNOWLIGHT'
    else
       selectedWeather = math.random() < 0.5 and 'XMAS' or 'BLIZZARD'
    end
    currentMonth = nil
    return selectedWeather
end

CreateThread(function()
    while true do
        GlobalState.currentWeather = getSeasonalWeather()
        Wait(300000)
    end
end)
