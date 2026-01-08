local ESX = exports['es_extended']:getSharedObject()
local usingPole = false
local nearestPole = nil

-- Event to reload config
RegisterNetEvent('feuerwehr:reloadConfig')
AddEventHandler('feuerwehr:reloadConfig', function()
    -- Config will be reloaded automatically as it's a shared script
    print('^2[Feuerwehr Rutschstange]^7 Config wurde neu geladen')
end)

-- Function to draw 3D text
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end

-- Show help text
function ShowHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, false, 100)
end

-- Main sliding function
function PoleSlide()
    CreateThread(function()
        usingPole = true
        local playerPed = PlayerPedId()
        
        while usingPole do
            if not IsEntityPlayingAnim(playerPed, Config.Animations.dict, Config.Animations.anim, 3) then
                TaskPlayAnim(playerPed, Config.Animations.dict, Config.Animations.anim, 8.0, 8.0, -1, 2, 1.0, false, false, false)
            end
            
            local pCoords = GetEntityCoords(playerPed)

            if math.abs(pCoords.z - nearestPole["End Z Coordinate"]) < 0.3 then
                -- Reached the bottom
                ClearPedTasksImmediately(playerPed)
                usingPole = false
                nearestPole = nil
                FreezeEntityPosition(playerPed, false)
                SetEntityCollision(playerPed, true, true)
                break
            else
                -- Continue sliding down
                local currPos = GetEntityCoords(playerPed)
                FreezeEntityPosition(playerPed, false)
                SetEntityCollision(playerPed, false, true)
                SetEntityCoordsNoOffset(playerPed, currPos.x, currPos.y, currPos.z - Config.PoleSpeed, true, true, true)
            end
            Wait(0)
        end
    end)
end

-- Function to start pole sliding
function StartPoleSlide(poleEntry, coord)
    if usingPole then return end
    
    -- Safety checks
    if not poleEntry or not coord then
        print("^1[Feuerwehr Rutschstange]^7 Error: Missing poleEntry or coord data")
        return
    end
    
    -- Position player at the pole
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, coord.x, coord.y, coord.z, true, true, true, false)
    SetEntityHeading(playerPed, poleEntry.Heading)
    
    -- Prepare for sliding
    FreezeEntityPosition(playerPed, true)
    TaskPlayAnim(playerPed, Config.Animations.dict, Config.Animations.anim, 8.0, 8.0, -1, 2, 1.0, false, false, false)
    
    -- Start sliding
    nearestPole = poleEntry
    Citizen.Wait(200)
    PoleSlide()
end

-- ox_target setup
if Config.ox_target then
    CreateThread(function()
        for name, poleEntry in pairs(Config.PoleLocations) do
            for _, coord in ipairs(poleEntry["Start Locations"]) do
                exports['ox_target']:addBoxZone({
                    coords = vector3(coord.x, coord.y, coord.z + 0.5),
                    size = vector3(1.0, 1.0, 2.2),
                    rotation = poleEntry.Heading or 0.0,
                    debug = Config.Debug,
                    drawSprite = true,
                    options = {
                        {
                            name = "fire_pole_" .. name,
                            icon = "fas fa-fire",
                            label = Config.Language.UsePole,
                            onSelect = function()
                                StartPoleSlide(poleEntry, coord)
                            end,
                            canInteract = function()
                                return not usingPole
                            end,
                            distance = 2.0
                        }
                    }
                })
            end
        end
    end)
end

-- Main thread (only runs when ox_target is disabled)
if not Config.ox_target then
    CreateThread(function()
        print("^2[Feuerwehr Rutschstange]^7 Script gestartet (Proximity Mode)")
        
        -- Preload animation dictionary
        RequestAnimDict(Config.Animations.dict)
        while not HasAnimDictLoaded(Config.Animations.dict) do
            Wait(100)
        end
        
        while true do
            local wait = 1000
            local playerPed = PlayerPedId()
            
            if not usingPole then
                for name, poleEntry in pairs(Config.PoleLocations) do
                    for _, coord in ipairs(poleEntry["Start Locations"]) do
                        if Config.Debug and Config.marker then
                            DrawMarker(0, coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 180, false, false, 2, false, nil, nil, false)
                        end
                        
                        if #(coord - GetEntityCoords(playerPed)) < Config.DistanceToPole then
                            wait = 0
                            ShowHelpText(Config.Language.UsePole)
                            
                            if IsControlJustReleased(0, Config.UsePoleControl) then
                                StartPoleSlide(poleEntry, coord)
                            end
                            break
                        end
                    end
                end
            end
            Wait(wait)
        end
    end)
else
    print("^2[Feuerwehr Rutschstange]^7 Script gestartet (ox_target Mode)")
end

-- Debug mode
if Config.Debug and Config.marker then
    CreateThread(function()
        while true do
            Wait(0)
            for name, poleEntry in pairs(Config.PoleLocations) do
                for _, coord in ipairs(poleEntry["Start Locations"]) do
                    DrawMarker(1, coord.x, coord.y, coord.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 0, 150, 255, 100, false, true, 2, false, false, false, false)
                end
            end
        end
    end)
end
