Config = {}

Config.Debug = false

Config.wreckTypes = {
    ['civwreck'] = {
		'iron', 'copper', 'scrapmetal',
		'garbage','garbage','money',
		'parachute','rolex','goldchain',
	},
	['milwreck'] = {
		'iron', 'copper', 'scrapmetal', -- Base Metals, useful to fill randoms
		'scrapmetal','garbage','money',
		'WEAPON_TACTICALRIFLE','WEAPON_PISTOL',
		'ammo-9','ammo-rifle','bodyarmor_1',
		
	},
    ['smuggler'] = {
		'iron', 'copper', 'scrapmetal',
		'garbage', 'coke_brick','coke_packaged',
		'money','black_money'

	},
	['cargo'] = {
		'iron', 'copper', 'scrapmetal',
		'garbage','garbage','garbage', -- More garbge you add, the more the ratios are shifted, player has a 30% Chance to receive these
		'television','WEAPON_CARBINERIFLE', -- This is the "Good Loot", 40% chance to receive one of these. If you want to change the odds, add/remove more filler
		'gold','diamond','money'
	},
}

Config.wrecks = {
	--Marine
	['CivWrecks'] = {
		model = 'ng_proc_box_01a',
		type = 'civwreck',
		spawnCoords = {
			vector3(-3190.4531, 3027.1724, -40.0), -- Zancudo Tug
			vector3(3396.2517, 6312.1094, -54.0339), -- Gordo Tug
			vector3(3907.4429, 3045.2859, -30.9), -- Davis Tug
			vector3(2662.1233, -1414.1171, -22.5), -- Tataviam Houseboat
			vector3(4826.7041, -4045.1016, -56.8) -- Cayo Houseboat
		},
	},

	['MilWrecks'] = {
		model = 'gr_prop_gr_rsply_crate02a',
		type = 'milwreck', 
		spawnCoords = {
			vector3(4178.4189, 3649.6040, -40.9), -- Humane Military Transport
			vector3(2637.6914, 6640.6470, -20.2), -- Gordo Submarine
			vector3(3949.8904, -5613.3462, -92.0) -- Cayo Military Transport
		},
	},

	--Aircraft
	['MilAircraft'] = {
		model = 'gr_prop_gr_rsply_crate03a',
		type = 'milwreck',
		spawnCoords = {
			vector3(-3339.2869, 3705.7813, -98.3),-- Zancudo Plane
			vector3(787.3239, 7363.2998, -127.7), -- Paleto UFO
		},
	},
	['CivAircraft'] = {
		model = 'prop_luggage_08a',
		type = 'civwreck',
		spawnCoords = {
			vector3(-889.1251, 6618.4727, -32.8), -- Paleto Jet
			vector3(1848.1396, -2963.5273, -53.2), -- Terminal Jet
			vector3(3269.8452, 6416.6660, -49.5), -- Gordo Duster
			vector3(5377.8960, -4202.6831, -58.1) -- Cayo Jet
		},
	},
	-- Mix
	['PericoSmugglers'] = {
		model = 'sm_prop_smug_crate_m_01a',
		type = 'smuggler', 
		spawnCoords = {
			vector3(3799.8511, -4089.0876, -45.7), -- Cayo FIB Luxor
			vector3(4459.3027, -5050.0425, -34.3), -- Cayo Smuggler Ship
		},
	},

	['CargoWrecks'] = {
		model = 'prop_box_wood02a',
		type = 'cargo',
		spawnCoords = {
			vector3(3178.2373, -359.1246, -30.1), -- NOOSE Cargo Ship
			vector3(255.5325, 4008.3037, -7.2) -- Alamo Jet
		},
	},
}