local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('ai:docOnline', function(source, cb)
	local src = source
	local Ply = QBCore.Functions.GetPlayer(src)
	local xPlayers = QBCore.Functions.GetPlayers()
	local doctor = 0
	local canpay = false
	if Ply.PlayerData.money["cash"] >= Config.Price then
		canpay = true
	end

	if Ply.PlayerData.money["bank"] >= Config.Price then
		canpay = true
	end

	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		if xPlayer.PlayerData.job.name == 'ambulance' then
			doctor = doctor + 1
		end
	end

	cb(doctor, canpay)
end)

RegisterServerEvent('ai:charge')
AddEventHandler('ai:charge', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.money["cash"] >= Config.Price then
		xPlayer.Functions.RemoveMoney("cash", Config.Price)
	end

	if xPlayer.PlayerData.money["bank"] >= Config.Price then
		xPlayer.Functions.RemoveMoney("bank", Config.Price)
	end

	TriggerEvent("qb-bossmenu:server:addAccountMoney", 'ambulance', Config.Price)
end)