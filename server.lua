ESX = exports['es_extended']:getSharedObject()

-- Add command to check if resource is working (for debugging)
RegisterCommand('checkpole', function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('esx:showNotification', src, '~g~Feuerwehr Rutschstange System ist aktiv!')
end, false)

-- Add command to reload config
RegisterCommand('reloadpoleconfig', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'admin') then
        TriggerClientEvent('feuerwehr:reloadConfig', -1)
        print('^2[Feuerwehr Rutschstange]^7 Config wurde neu geladen')
        if source ~= 0 then
            TriggerClientEvent('esx:showNotification', source, '~g~Config wurde neu geladen!')
        end
    end
end, false)

print('^2[Feuerwehr Rutschstange]^7 Server-Skript wurde erfolgreich gestartet')
