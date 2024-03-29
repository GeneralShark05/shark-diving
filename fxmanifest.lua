fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'General Shark'
description 'Dive for Loot'
version '1.4.1'

dependencies { 'ox_lib', 'ox_inventory', 'ox_target'}

shared_scripts {'@ox_lib/init.lua','config.lua'}

server_script 'server.lua'

client_script 'client.lua'

escrow_ignore {
    'server.lua',
    'config.lua',
    'client.lua',
  }