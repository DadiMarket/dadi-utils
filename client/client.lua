ESX = exports["es_extended"]:getSharedObject()

--Quita manitas
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if Dadi.aiming then
			local ped = PlayerPedId()
			if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then 
				DisableControlAction(2, 24, true) 
				DisableControlAction(2, 142, true)
				DisableControlAction(2, 257, true)
			end
		end
	end
end)

-- Disabledispatch / Desactiva los NPC de emergencia
Citizen.CreateThread(function()
	if Dadi.dispatchNPC then
		while (true) do
			Citizen.Wait(100)
			for i = 1, 12 do
				EnableDispatchService(i, false)
			end
			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), false)
			SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
		end
	end
end)

--Command rvoz
if Dadi.restarVoice then
	RegisterCommand(Dadi.voiceCommand, function()
		NetworkClearVoiceChannel()
		NetworkSessionVoiceLeave()
		Citizen.Wait(50)
		NetworkSetVoiceActive(false)
		MumbleClearVoiceTarget(2)
		Citizen.Wait(1000)
		MumbleSetVoiceTarget(2)
		NetworkSetVoiceActive(true)
		print('Voice reset' .. GetPlayerServerId(PlayerId()))
	end)
end

-- Comando para anticulataazo
Citizen.CreateThread(function()
	if Dadi.butt then
		while true do
			Citizen.Wait(0)
			local ped = PlayerPedId()

			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
		end
	end
end)

-- Evite que la cámara mire automáticamente a izquierda y derecha

Citizen.CreateThread(function()
	if Dadi.idleCam then
    	while true do
    	  InvalidateIdleCam()
    	  N_0x9e4cfff989258472()
    	  Wait(10000)
    	end
	end
end)

-- // ELIMINAR NPC O CONTROLAR DENSIDAD //
Citizen.CreateThread(function()
	if Dadi.removeNPC then
    	while true do
    	    Citizen.Wait(0) -- Prevent crashing.

			-- Stop Spawn
			SetCreateRandomCops(false)
			SetCreateRandomCopsNotOnScenarios(false)
			SetCreateRandomCopsOnScenarios(false)
			SetGarbageTrucks(Dadi.garbageTrucks)
			SetRandomBoats(Dadi.randomBoats)
    	   	SetVehicleDensityMultiplierThisFrame(0.0)
    	   	SetPedDensityMultiplierThisFrame(Dadi.densityMultiplier)
			SetRandomVehicleDensityMultiplierThisFrame(Dadi.vehicleDensity)
			SetScenarioPedDensityMultiplierThisFrame(Dadi.densityMultiplier, Dadi.densityMultiplier)
			SetParkedVehicleDensityMultiplierThisFrame(Dadi.vehicleDensity)

			-- Clear NPC
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    	end
	end
end)

-- NPC AMIGABLES
local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY',
	'DEALER',
	'COP',
	'PRIVATE_SECURITY',
	'SECURITY_GUARD',
	'ARMY',
	'MEDIC',
	'FIREMAN',
	'HATES_PLAYER',
	'NO_RELATIONSHIP',
	'SPECIAL',
	'MISSION2',
	'MISSION3',
	'MISSION4',
	'MISSION5',
	'MISSION6',
	'MISSION7',
	'MISSION8'
}

Citizen.CreateThread(function()
	while true do
		if Dadi.enemyNPC then
			Citizen.Wait(5000)
			for _, group in ipairs(relationshipTypes) do
				SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group)) -- could be removed
				SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
			end
		end
	end
end)

 -- Probar colores de los coches
-- RegisterCommand("testcolor", function(source, args)
--     local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
--     SetVehicleModKit(vehicle, 0)
--     SetVehicleColours(vehicle, tonumber(args[1]), tonumber(args[1]))
-- end)

-- /// TEXTOS 3D ///
-- Citizen.CreateThread(function() 
--     while true do   
		
--         if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
--             local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
--             local lock = GetVehicleDoorLockStatus(veh)

--             if lock == 7 then
--                 SetVehicleDoorsLocked(veh, 2)
--             end
                 
--             local pedd = GetPedInVehicleSeat(veh, -1)

--             if pedd then                   
--                 SetPedCanBeDraggedOut(pedd, false)
--             end             
--         end   
--         Citizen.Wait(1)	
-- 		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1840.5737, 3669.9814, 33.6801, true) <= 22 then 
-- 			Drawing.draw3DText(1847.0166, 3670.9006, 31.6903 + 1.700, "Mira el canal de guias en discord!", 4, 0.3, 0.2)
-- 			Drawing.draw3DText(1843.4349, 3665.7129, 33.8161, "Los empleos están distribuidos por el mapa! ", 4, 0.3, 0.2)
-- 			Drawing.draw3DText(1837.4723, 3666.9990, 33.6800 - .700, "Visita la comisaría o el hospital para conocer gente", 4, 0.3, 0.2)
-- 		end
-- 	end
-- end)


Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(1, 1, 1, 0, 255)
    SetTextEdge(2, 0, 0, 0, 220)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- /// ROBO A PERSONAS ///
-- exports["ox_target"]:addGlobalPlayer({
--     {
--         name = 'search:player',
--         icon = 'fa-solid fa-magnifying-glass',
--         label = 'Robar Jugador',
--         canInteract = function(entity, distance, coords, name, bone)
--             return IsEntityPlayingAnim(entity, 'dead', 'dead_a', 3)
--             or IsPedCuffed(entity)
--             or IsEntityPlayingAnim(entity, 'mp_arresting', 'idle', 3)
--             or IsEntityPlayingAnim(entity, 'missminuteman_1ig_2', 'handsup_base', 3)
--             or IsEntityPlayingAnim(entity, 'missminuteman_1ig_2', 'handsup_enter', 3)
--             or IsEntityPlayingAnim(entity, 'random@mugging3', 'handsup_standing_base', 3)
--         end,
-- 		onSelect = function(data)
-- 			TriggerEvent('dadi-utils:stealingItems')
-- 		end,
-- 		distance = 1.0
--     },
-- })

-- RegisterNetEvent('dadi-utils:stealingItems')
-- AddEventHandler('dadi-utils:stealingItems', function(closestPlayer)
-- 	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--     if closestPlayer ~= -1 and closestDistance <= 3.0 then
--         TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(closestPlayer))
-- 		print('persona encontrada:' ..closestPlayer)
--     end
-- end)