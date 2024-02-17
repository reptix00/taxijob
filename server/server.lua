-- lib.callback.register('taxijob:getJob', function (source)
--     local playerId = source
--     local xPlayer = ESX.GetPlayerFromId(playerId)
--     local jobName = xPlayer.getJob().name

--     return jobName == 'taxi'
-- end)


function framework_removeMoney(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeMoney(amount)
end
RegisterServerEvent("taxijob:spawnVehicle")
	AddEventHandler('taxijob:spawnVehicle', function(data)
        pcall(function()
            function_framework_removeMoney(source, data.price)
            
            ESX.Game.SpawnVehicle(data.name, data.spawnCoords, data.spawnHeading, function (spawnedVehicle)
            end)
        end, function(err)
            print("Error in spawning vehicle or renoving money: " .. err)
        end)
	end)
