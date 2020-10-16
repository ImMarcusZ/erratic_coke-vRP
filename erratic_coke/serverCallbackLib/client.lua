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

viMA = {}
viMA.CurrentRequestId          = 0
viMA.ServerCallbacks           = {}

viMA.TriggerServerCallback = function(name, cb, ...)
	viMA.ServerCallbacks[viMA.CurrentRequestId] = cb

	TriggerServerEvent('viMA:triggerServerCallback', name, viMA.CurrentRequestId, ...)

	if viMA.CurrentRequestId < 65535 then
		viMA.CurrentRequestId = viMA.CurrentRequestId + 1
	else
		viMA.CurrentRequestId = 0
	end
end

RegisterNetEvent('viMA:serverCallback')
AddEventHandler('viMA:serverCallback', function(requestId, ...)
	viMA.ServerCallbacks[requestId](...)
	viMA.ServerCallbacks[requestId] = nil
end)

AddEventHandler('viMA:getSharedObject', function(cb)
	cb(viMA)
end)

function getSharedObject()
	return viMA
end
