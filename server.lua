------------------------------------------------------------
-- Startup --
------------------------------------------------------------
local ox_inventory = exports.ox_inventory

local function merge(table1, table2)
    local table3 = table1
    for k, v in pairs(table2) do
        table.insert(table1, v)
    end
    return table3
end

local function prizeGen(type)
    local lootTable = merge(Config.wreckTypes[type], Config.DefaultItems)
    local reward = nil

    if lootTable ~= nil then
        local max = #lootTable
        reward = lootTable[choice]
    end

    while reward == nil do
        for k, item in pairs(lootTable) do
            local choice = math.random(100)
            if choice <= item[3] then
                reward = item
            end
        end
    end
    return reward
end

RegisterServerEvent('sharkdiving:collected')
AddEventHandler('sharkdiving:collected', function(type, success)
    local src = source
    if success then
        local reward = prizeGen(type)
        local item, min, max, calc = table.unpack(reward)
        local quantity = math.random(min, max)

        ox_inventory:AddItem(src, item, quantity)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You grabbed the loot.'})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You damaged the salvage!'})
    end
end)


