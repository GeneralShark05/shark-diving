------------------------------------------------------------
-- Startup --
------------------------------------------------------------
local ox_inventory = exports.ox_inventory

local function prizeGen(type)
    local category = Config.wreckTypes[type]
    local reward = 'water'
    if category ~= nil then
        local max = #category
        local choice = math.random(1, max)
        reward = category[choice]
    end
    return reward
end

RegisterServerEvent('sharkdiving:collected')
AddEventHandler('sharkdiving:collected', function(type, success)
    local src = source
    if success then
        local quantity = math.random(4)
        local reward = prizeGen(type)
        ox_inventory:AddItem(src, reward, quantity)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You grabbed the loot.'})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You damaged the salvage!'})
    end
end)


