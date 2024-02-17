fx_version 'cerulean'
games { 'gta5' }
use_experimental_fxv2_oal 'yes'
lua54 'yes'

author 'Reptix'
description 'Jobplayercount'
version '1.0'

dependencies {
    'oxmysql',
    'ox_lib',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_scripts {
    'client.lua',
    'Config.lua',
    'missions.lua'
} 

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}