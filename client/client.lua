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