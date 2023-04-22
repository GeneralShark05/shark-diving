------------------------------------------------------------
-- Startup --
------------------------------------------------------------
local ox_inventory = exports.ox_inventory

local function shuffle(table)
    for i = #table, 2, -1 do
      local j = math.random(i)
      table[i], table[j] = table[j], table[i]
    end
    return table
end

local function merge(table1, table2)
    local table3 = table1
    for k, v in pairs(table2) do
        table.insert(table3, v)
    end
    local table4 = shuffle(table3)
    return table4
end

local function prizeGen(type)
    math.randomseed(GetGameTimer())
    local lootTable = merge(Config.wreckTypes[type], Config.DefaultItems)
    local reward = nil

    while reward == nil do
        local choice = math.random(1000)
        if Config.Debug then print(choice) end
        for k, item in pairs(lootTable) do
            if Config.Debug then print('thinking - '..item[1]..' '..item[4]) end
            if choice <= (item[4]*10) then
                reward = item
                if Config.Debug then print('reward = '..reward[1]) end
                return reward
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


