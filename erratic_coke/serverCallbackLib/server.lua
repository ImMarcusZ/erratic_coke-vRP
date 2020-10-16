viMA = {}
viMA.ServerCallbacks = {}

RegisterServerEvent('viMA:triggerServerCallback')
AddEventHandler('viMA:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	viMA.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('viMA:serverCallback', _source, requestId, ...)
	end, ...)
end)

viMA.RegisterServerCallback = function(name, cb)
	viMA.ServerCallbacks[name] = cb
end

viMA.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if viMA.ServerCallbacks[name] ~= nil then
		viMA.ServerCallbacks[name](source, cb, ...)
	else
		print('erratic_coke => [' .. name .. '] does not exist')
	end
end

AddEventHandler('viMA:getSharedObject', function(cb)
	cb(viMA)
end)

function getSharedObject()
	return viMA
end
