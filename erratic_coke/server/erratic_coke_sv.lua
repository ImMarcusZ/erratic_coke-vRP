-- CONVERTED TO VRP FROM ESX BY:

-- ██╗   ██╗██╗███╗   ██╗███╗   ██╗██╗   ██╗     █████╗ ███╗   ██╗██████╗          
-- ██║   ██║██║████╗  ██║████╗  ██║╚██╗ ██╔╝    ██╔══██╗████╗  ██║██╔══██╗         
-- ██║   ██║██║██╔██╗ ██║██╔██╗ ██║ ╚████╔╝     ███████║██╔██╗ ██║██║  ██║         
-- ╚██╗ ██╔╝██║██║╚██╗██║██║╚██╗██║  ╚██╔╝      ██╔══██║██║╚██╗██║██║  ██║         
-- ╚████╔╝ ██║██║ ╚████║██║ ╚████║   ██║       ██║  ██║██║ ╚████║██████╔╝         
-- ╚═══╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝          
--                                                                                 
-- ▄▄███▄▄·      ███╗   ███╗ █████╗ ██████╗  ██████╗██╗   ██╗███████╗      ▄▄███▄▄·
-- ██╔════╝      ████╗ ████║██╔══██╗██╔══██╗██╔════╝██║   ██║██╔════╝      ██╔════╝
-- ███████╗█████╗██╔████╔██║███████║██████╔╝██║     ██║   ██║███████╗█████╗███████╗
-- ╚════██║╚════╝██║╚██╔╝██║██╔══██║██╔══██╗██║     ██║   ██║╚════██║╚════╝╚════██║
-- ███████║      ██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╗╚██████╔╝███████║      ███████║
-- ╚═▀▀▀══╝      ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝      ╚═▀▀▀══╝

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "erratic_coke")


local hiddenprocess = vector3(-331.7995, -2444.753, 7.358099) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords
local hiddenstart = vector3(-480.7245, 6266.324, 13.63469) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords

RegisterNetEvent('coke:updateTable')
AddEventHandler('coke:updateTable', function(bool)
    TriggerClientEvent('coke:syncTable', -1, bool)
end)

viMA.RegisterServerCallback('coke:processcoords', function(source, cb)
    cb(hiddenprocess)
end)

viMA.RegisterServerCallback('coke:startcoords', function(source, cb)
    cb(hiddenstart)
end)

viMA.RegisterServerCallback('coke:pay', function(source, cb)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local price = Config.price
	local check = vRP.getBankMoney({user_id})
	if check >= price then
		vRP.tryWithdraw({user_id,price})
    	cb(true)
    else
      if Config.useMythic then
    	 TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'du har ikke nok penge.'})
      end
    	cb(false)
    end
end)

RegisterServerEvent("coke:processed")
AddEventHandler("coke:processed", function(x,y,z)
	local _source = source
	local user_id = vRP.getUserId({_source})
  	local pick = Config.randBrick
	vRP.tryGetInventoryItem({user_id,"kokain",Config.takeBrick,false})
	vRP.giveInventoryItem({user_id,'kokain',pick,1})
end)

viMA.RegisterServerCallback('coke:process', function(source, cb)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local check = vRP.getInventoryItemAmount(user_id,"kokain")
	if check >= 1 then
    	cb(true)
    else
      if Config.useMythic then
    	 TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Du har ikke nok kokainklumper'})
      end
    	cb(false)
	end
end)

RegisterServerEvent("coke:GiveItem")
AddEventHandler("coke:GiveItem", function()
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRP.giveInventoryItem({user_id,"kokain",50})
end)