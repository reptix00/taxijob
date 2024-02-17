Config = {}

Config.Locale = 'en'
Config.TaxiJobs =  { "taxi", "escort" }
Config.Jobs = {
    ['taxi'] = {
        label = 'Taxi',
        coords = {
            ['start'] = {x = 903.0, y = -179.0, z = 74.0},
            ['finish'] = {x = 903.0, y = -179.0, z = 74.0}
        }
    }
    ['escort'] = {
        label = 'Escort',
        coords = {
            ['start'] = {x = 903.0, y = -179.0, z = 74.0},
            ['finish'] = {x = 903.0, y = -179.0, z = 74.0}
        }
    }
}

Config.Cars = {
    ['taxi'] = {
        {name = 'taxi', label = 'Taxi', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
        {name = 'taxi2', label = 'Taxi2', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
        {name = 'taxi3', label = 'Taxi3', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
    }
    ['escort'] = {
        {name = 'escort', label = 'Escort', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
        {name = 'escort2', label = 'Escort2', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
        {name = 'escort3', label = 'Escort3', price = 1000, spawnCoords = vector3(903.0, -179.0, 74.0), spawnHeading = 0.0},
    }
}

Config.Translations = {
    ["de"] = {
        ["showhelpnotification"] = "Drücke ~INPUT_CONTEXT~ um den Job zu starten",
    }
    ["en"] = {
        ["showhelpnotification"] = "Press ~INPUT_CONTEXT~ to start the job",
    }
}