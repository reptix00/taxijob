local StartMissionCoords = {vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0)}
local EndMissionCoords = {vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0), vector3(0,0,0)}
local MissionType = {'Standard', 'Premium'}



local currentStartMissionCoords;
local currentEndMissionCoords;
local currentMissionType;

local menuElements = {}


RegisterCommand(
	'mission' --[[ string ]], 
	function ()
       
    currentStartMissionCoords = StartMissionCoords[math.random(1, #StartMissionCoords)]
    currentEndMissionCoords = EndMissionCoords[math.random(1, #EndMissionCoords)]
    currentMissionType = MissionType[math.random(1, #MissionType)]

    local reward = (#currentStartMissionCoords - #EndMissionCoords)

    lib.notify({
        title = 'Mission',
        description = 'Start: '..currentStartMissionCoords..' End: '..currentEndMissionCoords..' Type: '..currentMissionType..' Reward: '..reward
    }
    )

SetNewWaypoint(currentEndMissionCoords.x, currentEndMissionCoords.y) 

    end --[[ func ]], 
	false --[[ boolean ]]
)


local function createPedToEnterTheJobVehicle()


end