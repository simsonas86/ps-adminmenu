-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(_, selectedData)
    local player = selectedData["Player"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenInv", player)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", player)
    end
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(_, selectedData)
    local stash = selectedData["Stash"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    end
end)

-- Open Trunk
RegisterNetEvent('ps-adminmenu:client:openTrunk', function(_, selectedData)
    local vehiclePlate = selectedData["Plate"].value

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenTrunk", vehiclePlate)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "trunk", tostring(vehiclePlate))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(vehiclePlate))
    end
end)
