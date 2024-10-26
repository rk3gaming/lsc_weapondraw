local function displayNotification()
    lib.notify({
        id = 'weapon_alert',
        title = 'Weapon Drawn',
        description = 'You have drawn a weapon.',
        showDuration = false,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'circle-info',
        iconColor = '#1167e7'
    })
end

RegisterNetEvent('ox_inventory:currentWeapon')
AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    if weapon and weapon.name ~= "WEAPON_UNARMED" then 
        displayNotification()
    end
end)
