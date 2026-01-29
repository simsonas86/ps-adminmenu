-- Changes the time
RegisterNetEvent('ps-adminmenu:client:ChangeTime', function(data, selectedData)
    local time = selectedData["Time Events"].value

    if not time then return end

    TriggerServerEvent('qb-weathersync:server:setTime', time, 00)
end)

-- Changes the weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(data, selectedData)
    local weather = selectedData["Weather"].value

    TriggerServerEvent('qb-weathersync:server:setWeather', weather)
end)

RegisterNetEvent('ps-adminmenu:client:copyToClipboard', function(data, selectedData)
    local dropdown = selectedData["Copy Coords"].value
    local ped = PlayerPedId()
    local string = nil
    if dropdown == 'vector2' then
        local coords = GetEntityCoords(ped)
        local x = ps.decimalRound(coords.x, 2)
        local y = ps.decimalRound(coords.y, 2)
        string = "vector2(".. x ..", ".. y ..")"
        ps.notify(locale("copy_vector2"), 'success')
    elseif dropdown == 'vector3' then
        local coords = GetEntityCoords(ped)
        local x = ps.decimalRound(coords.x, 2)
        local y = ps.decimalRound(coords.y, 2)
        local z = ps.decimalRound(coords.z, 2)
        string = "vector3(".. x ..", ".. y ..", ".. z ..")"
        ps.notify(locale("copy_vector3"), 'success')
    elseif dropdown == 'vector4' then
        local coords = GetEntityCoords(ped)
        local x = ps.decimalRound(coords.x, 2)
        local y = ps.decimalRound(coords.y, 2)
        local z = ps.decimalRound(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = ps.decimalRound(heading, 2)
        string = "vector4(".. x ..", ".. y ..", ".. z ..", ".. h ..")"
        ps.notify(locale("copy_vector4"), 'success')
    elseif dropdown == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = ps.decimalRound(heading, 2)
        string = h
        ps.notify(locale("copy_heading"), 'success')
    elseif string == nil then 
        ps.notify(locale("empty_input"), 'error')
    end

    lib.setClipboard(string)

end)