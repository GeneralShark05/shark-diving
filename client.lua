local lootsNet = {}
local lootCount = 0
local isGathering = false

------------------------------------------------------------
-- Coords --
------------------------------------------------------------
local function getCoordZ(x, y, z)
	local foundGround, zCoord = GetGroundZFor_3dCoord(x, y, z, false)
	return zCoord
end

local function lootCoords(coordX, coordY, coordZ)
	local x, y
	local modRadius1 = (Config.Radius / 2)
	local modRadius2 = (modRadius1 * -1)

	math.randomseed(GetGameTimer())
	local modX = math.random(modRadius2, modRadius1)

	Wait(100)

	math.randomseed(GetGameTimer())
	local modY = math.random(modRadius2, modRadius1)

	x = coordX + modX
	y = coordY + modY

	local z = getCoordZ(x, y, coordZ)
	local coords = vector3(x, y, z)
	return coords
end
------------------------------------------------------------
-- Spawn Loots --
------------------------------------------------------------
local function deleteLoots()
	for k, v in pairs(lootsNet) do
		local netId = NetworkGetNetworkIdFromEntity(v)
		exports.ox_target:removeEntity(netId, 'shark:pick')
		DeleteObject(v)
		if Config.Debug == true then
			print("Deleted " .. v .. " Count: " .. lootCount)
		end
		lootCount = lootCount - 1
	end
	lootsNet = {}
end

local function spawnLoots(type, spawnpoint)
    local options = {}
    if Config.Debug then print(type) end
    local model = Config.wrecks[type].model
    if Config.Debug then print(model) end
    options = {
        {
            name = 'shark:pick',
            icon = 'fa-solid fa-hand',
            label = 'Grab Loot',
            onSelect = function(data)
                TriggerEvent('sharkdiving:OpenLoot', data.entity, type, spawnpoint)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return distance < 5.5 and not isGathering
            end
        }
    }
	local modelHash = GetHashKey(model)

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
	Citizen.CreateThread(function()
		while lootCount < 6 do
			local entityReady = false
			local coords = lootCoords(Config.wrecks[type].spawnCoords[spawnpoint].x,
				Config.wrecks[type].spawnCoords[spawnpoint].y, Config.wrecks[type].spawnCoords[spawnpoint].z)
			local obj = CreateObject(modelHash, vector3(coords), true, true)
			while not entityReady do
				Wait(100)
				if Config.Debug then print(DoesEntityExist(obj)) end
				entityReady = DoesEntityExist(obj)
				if Config.Debug then print("Entity spawning please wait..") end
			end
			if Config.Debug then print('STATEROTATE') end
			local rotation = math.random(1, 360) + 0.01
			SetEntityHeading(obj, rotation)
			if Config.Debug then print('STATEFREEZE') end
			FreezeEntityPosition(obj, true)
			if Config.Debug then print('STATEID') end
			Wait(500)
			local netId = NetworkGetNetworkIdFromEntity(obj)
			if Config.Debug then print('STATETABLE') end
			table.insert(lootsNet, obj)
			if Config.Debug then print('STATETARGET') end
			exports.ox_target:addEntity(netId, options)
			if Config.Debug then print('FINALSTATE') end
			if Config.Debug then print("Created a " .. type .. spawnpoint .. " Count: " .. lootCount) end
			lootCount = lootCount + 1
		end
	end)
end
------------------------------------------------------------
-- Collect Loot --
------------------------------------------------------------
RegisterNetEvent("sharkdiving:OpenLoot")
AddEventHandler('sharkdiving:OpenLoot', function(entity, type, zone)
	isGathering = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyID
	exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(entity), 'shark:pick')

	for i = 1, #lootsNet, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(lootsNet[i]), false) < 5 then
			nearbyID = i
		end
	end

	if lib.progressBar({
			duration = 2500,
			label = 'Looting...',
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false
			},
		})
	then
		local success = lib.skillCheck('easy', 'e')
		TriggerServerEvent('sharkdiving:collected', Config.wrecks[type].type, success)
		table.remove(lootsNet, nearbyID)
		DeleteObject(entity)
		lootCount = lootCount - 1

		Citizen.CreateThread(function()
			Wait(5000)
			spawnLoots(type, zone)
		end)
	end
	isGathering = false
end)

------------------------------------------------------------
-- Create Spheres --
-----------------------------------------------------------
local function onEnter(self)
    spawnLoots(self.wreckType, self.wreckZone)
end

local function onExit(self)
    deleteLoots()
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.wrecks) do
        for k2, v2 in pairs(Config.wrecks[k].spawnCoords) do
            local sphere = lib.zones.sphere({
                coords = Config.wrecks[k].spawnCoords[k2],
                radius = (Config.Radius + 5),
                debug = Config.Debug,
                onEnter = onEnter,
                onExit = onExit,
                wreckType = k,
                wreckZone = k2,
            })
        end
    end
end)