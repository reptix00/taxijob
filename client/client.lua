
function Locale(msg)
    return Config.Translations[Config.Locale][msg] or msg
end
-- why this below me? because..
--[[
if someone changes the job, lets say they get a new job. then the job is updated in the ESX.PlayerData.job.name. so we can use this to check if the player has the taxi job. if he has the taxi job, then we can show the menu. if he doesn't have the taxi job, then we don't show the menu.
    if this wouldnt be here, the job would be forever stuck on the job that the player had when he joined the server. so if he had the taxi job when he joined the server, then he would always have the taxi job. even if he changed the job. so this is why we need to update the job.
        :) i hope this is clear.
    if this is not clear, then i can explain it again. but i think this is clear enough.
]]

RegisterNetEvent('esx:setJob', function(player, job, lastJob)
   ESX.PlayerData.job = job
end)



function IsAnyCarTaken(args)
    for k,v in pairs(args) do
        if v.taken then
            return true
        end
    end
    return false
end

blips = {}
function CreateBlips()
    for k,v in pairs(Config.Jobs) do
        local blip = AddBlipForCoord(v.coords.start.x, v.coords.start.y, v.coords.start.z)
        SetBlipSprite(blip, 198)
        SetBlipColour(blip, 5)
        SetBlipScale(blip, 0.5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)#
        table.insert(blips, blip)
    end
end
function CreateZones()
    for k,v in pairs(Config.Jobs) do
        insidezone = lib.points.new({
            coords = vector3(v.coords.start.x, v.coords.start.y, v.coords.start.z),
            distance = 30,
        })
       function insidezone:onEnter()
        if lib.table.contains(Config.TaxiJobs, ESX.PlayerData.job.name) then
                if ESX.PlayerData.job.name == 'taxi' then
                    ESX.ShowHelpNotification(Locale('showhelpnotification'))
                    if IsControlJustReleased(0, 38) then
                        OpenBuyVehicleMenu()
                    end
                end
        end
    end
        function insidezone:onExit()
            lib.hideMenu(onExit)
        end

        markerzone = lib.points.new({
            coords = vector3(v.coords.start.x, v.coords.start.y, v.coords.start.z),
            distance = 30,
        })
        function markerzone:onEnter()
            DrawMarker(2, v.coords.start.x, v.coords.start.y, v.coords.start.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)  
        end
    end

end



function OpenBuyVehicleMenu()
    lib.registerMenu({
        id = 'GetVehicleMenu',
        title = Locale('getvehiclemenu'),
        position = 'top-left',
        options = {},
        onSelected = function(selected, secondary, args)
                if IsAnyCarTaken(args) then
                    ESX.ShowNotification(Locale('vehiclebought'))
                    return
                end
                if ESX.PlayerData.money < car.price then
                    ESX.ShowNotification(Locale('notenoughmoney'))
                    return
                end
                TriggerServerEvent('taxijob:buyVehicle', car.name, car.price) -- ich spawn das auto jetzt server side, ist sicherer vor hackern :) 
                args[argskey].taken = true -- this adds .taken to the car table and sets it to true so the car can't be taken again this is a temporary method, and shouldnt be done like this, because as soon as you restart teh script it will not work. but hey. its okay for a beginner. if i do it otherwise. this would go on for ages
        end,
    }, function(selected, scrollIndex, args)
    end)
    local i = 1
    for carsKey,carValue in pairs(Config.Cars) do
        lib.setMenuOptions('GetVehicleMenu', {label = cars[carsKey].name, icon = 'plus', args = cars[carskey]}, i)
        i += 1
    end
    lib.showMenu('GetVehicleMenu')
end

CreateBlips() -- creates blips
CreateZones() -- creates zones
