lib.callback.register('taxijob:getJob', function (source)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local jobName = xPlayer.getJob().name

    return jobName == 'taxi'
end)