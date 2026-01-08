Config = {}
Config.Language = {}

-- Main configuration
Config.Debug = false -- Enable this to show a marker at your pole locations in game
Config.marker = false
Config.DistanceToPole = 1.2 -- Distance to the pole that the use prompt will show
Config.UsePoleControl = 51 -- The control to use the pole, default E (51 is E key)
Config.PoleSpeed = 0.1 -- Speed at which the player slides down the pole
-- ox_target configuration
Config.ox_target = true -- Enable ox_target support (false for default proximity system)

-- 3D Text configuration
Config.Text3d = true -- Testen mit e du kennst Rutschstage
Config.marker = false
-- Animation configuration
Config.Animations = {
    dict = "move_climb",
    anim = "climb_idle"
}

-- Pole locations
Config.PoleLocations = {

    ["bf"] = {
        ["Start Locations"] = {
            vector3(964.9288, -2538.4819, 31.5014)  -- Top of the pole
        },
        ["End Z Coordinate"] = 27.5014,  -- Bottom Z coordinate (estimated)
        ["Heading"] = 62.2247  -- Facing direction when sliding
    }
}

-- Language settings
Config.Language.UsePole = "Drücke E um die Rutschstange zu benutzen"