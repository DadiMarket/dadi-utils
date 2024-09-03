fx_version 'cerulean'
games { 'gta5' }

author 'DADI MARKET'
description 'https://discord.gg/BFerjVVwJK'
version '1.0.1'

lua54 'yes'
client_scripts {
    'client/*.lua'
}

server_script 'server/*.lua'

shared_scripts {
    'shared/*.lua'
}
   
escrow_ignore {
	'shared/*.lua',
    'client/cl_utils.lua',
}