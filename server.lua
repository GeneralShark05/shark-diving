------------------------------------------------------------
-- Startup --
------------------------------------------------------------
local ox_inventory = exports.ox_inventory

local function merge(table1, table2)
    for k, v in pairs(table2) do
        table.insert(table1, v)
    end
    return table1
end

local function prizeGen(type)
    local lootTable = merge(Config.wreckTypes[type], Config.DefaultItems)
    local reward = {'water', 1, 5}
    if lootTable ~= nil then
        local max = #lootTable
        local choice = math.random(1, max)
        reward = lootTable[choice]
    end
    return reward
end

RegisterServerEvent('sharkdiving:collected')
AddEventHandler('sharkdiving:collected', function(type, success)
    local src = source
    if success then
        local reward = prizeGen(type)
        local item, min, max = table.unpack(reward)
        local quantity = math.random(min, max)

        ox_inventory:AddItem(src, item, quantity)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You grabbed the loot.'})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You damaged the salvage!'})
    end
end)


