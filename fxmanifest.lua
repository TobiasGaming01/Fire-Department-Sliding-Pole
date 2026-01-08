fx_version 'cerulean'
game 'gta5'

author 'Tobias'
description 'A realistic and interactive sliding pole system for FiveM fire department roleplay. Features custom animations, optimized performance, and seamless integration with ESX.'
version '1.0.1'

client_scripts {
    'client.lua',
    'system/Rutschstange.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    'config.lua'
}

-- Required for ESX
dependencies {
    'es_extended'
}