
-- local taxiJobPositiob = {blip = vector3(0, 0, 0), getVehicle = {x = 3.89,y =  7.05,z = 70.79}, bringVehicleBack = vector3(0,0,0)}
-- local cars = ({adder = {name = 'Adder', price = 1000, spawnCoords = vector3(-1.55, 13.25, 70.91), spawnHeading = 260.78}, balista = {name = 'Balista', price = 2000,  spawnCoords = vector3(0,0,0)}})

local carIsSpawned = false
local vehiclePlate = nil
local taxiVehicle = nil
hasTookVehicle = false
local isVehicleExist = false

function locale(msg)
    return Config.Translations[Config.Locale][msg] or msg
end

RegisterNetEvent('esx:setJob', function(player, job, lastJob)
   ESX.PlayerData.job = job
end)



blips = {}
function createBlips()
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
function createZones()
    for k,v in pairs(Config.Jobs) do
        insidezone = lib.points.new({
            coords = vector3(v.coords.start.x, v.coords.start.y, v.coords.start.z),
            distance = 30,
        })
       function insidezone:onEnter()
        if lib.table.contains(Config.TaxiJobs, ESX.PlayerData.job.name) then
                if ESX.PlayerData.job.name == 'taxi' then
                    ESX.ShowHelpNotification(locale('showhelpnotification'))
                    if IsControlJustReleased(0, 38) then
                        openMenuWithContents()
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


-- Citizen.CreateThread(function ()
--     local jobBlip = CreateBlip('Taxi Job', 198, 5, 0.5, taxiJobPositiob.blip.x, taxiJobPositiob.blip.y, taxiJobPositiob.blip.z)

--     local vehicleBuy = lib.points.new({
--         coords = vector3(taxiJobPositiob.getVehicle.x, taxiJobPositiob.getVehicle.y, taxiJobPositiob.getVehicle.z),
--         distance = 5,
--     })
     
     
--     function vehicleBuy:onExit()
--         lib.hideMenu(onExit)
--     end
     
--     function vehicleBuy:nearby()     
--        if ESX.PlayerData.job.name == 'taxi' then
--             ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um das Fahrzeug zu nehmen')
--             if(IsControlJustReleased(0, 38)) then
--             openMenuWithContents()
--             end
--         end
--        end
-- end)

function openMenuWithContents()
    lib.registerMenu({
        id = 'GetVehicleMenu',
        title = 'Taxi Fahrzeug beanspruchen',
        position = 'top-left',
        options = {},
        onSelected = function(_, _, args, _)
            for _,car in pairs (args) do
                if isVehicleExist then
                    ESX.ShowNotification('Das Fahrzeug ist bereits gespawnt')
                    return
                end
                ESX.Game.SpawnVehicle(car.name, car.spawnCoords, car.spawnHeading, function (spawnedVehicle)
                    print('Spawned'..car.name)
                    vehiclePlate = GetVehicleNumberPlateText(spawnedVehicle)
                    print(vehiclePlate)
                    hasTookVehicle = true
                    Citizen.CreateThread(function ()

                        while true do 
                            Wait(0)
                            isVehicleExist = DoesEntityExist(spawnedVehicle)    
                            print(DoesEntityExist(spawnedVehicle))    
                        end
                       
                    end)
                end)
            end

        end,
    }, function(selected, scrollIndex, args)
    end)
    local i = 1
    for carsKey,carValue in pairs(cars) do
        lib.setMenuOptions('GetVehicleMenu', {label = cars[carsKey].name, icon = 'plus', args = {carValue}}, i)
        i = i+1
    end
    lib.showMenu('GetVehicleMenu')
end



--   Citizen.CreateThread(function ()
--     while true do
--        Wait(-1)
--         if ESX.PlayerData?.job and ESX.PlayerData?.job.name == 'taxi' then 
--             DrawMarker(2, taxiJobPositiob.getVehicle.x, taxiJobPositiob.getVehicle.y, taxiJobPositiob.getVehicle.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)  
--     end
--   end
-- end)

--  function CreateBlip(name, id, color, size, blipX, blipY, blipZ)
--     local blip = AddBlipForCoord(blipX, blipY, blipZ)
--     SetBlipSprite(blip, id)
--     SetBlipColour(blip, color)
--     SetBlipScale(blip, size)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("Taxi Job")
--     EndTextCommandSetBlipName(blip)
--     return blip
-- end





createBlips()
createZones()
