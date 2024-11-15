local lastWeaponState = "holstered"  
local lastAmmoCount = 0  
local lastWeaponHash = nil  

local function getWeaponLabel(weaponHash)
    local weaponLabel = GetWeaponLabel(weaponHash)  
    return weaponLabel or "Unknown Weapon"
end

local function displayWeaponDrawnNotification(currentAmmo)
    lib.notify({
        id = 'weapon_alert',
        title = 'Weapon Drawn',
        description = string.format('You have drawn a firearm with %d rounds.', currentAmmo),
        showDuration = 500,  
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

local function displayWeaponHolsteredNotification(currentAmmo)
    lib.notify({
        id = 'weapon_alert',
        title = 'Weapon Holstered',
        description = string.format('You have holstered a firearm with %d rounds left.', currentAmmo),
        showDuration = 500, 
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

local function displayReloadNotification(ammoReloaded, currentAmmo)
    lib.notify({
        id = 'reload_alert',
        title = 'Reloading Weapon',
        description = string.format('You reloaded %d rounds. Total ammo: %d.', ammoReloaded, currentAmmo),
        showDuration = 500, 
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

CreateThread(function()
    while true do
        Wait(100)

        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        
        if weapon ~= `WEAPON_UNARMED` then
            local currentAmmo = GetAmmoInPedWeapon(ped, weapon)

            if lastWeaponState == "holstered" then
                displayWeaponDrawnNotification(currentAmmo)
                lastWeaponState = "drawn"
                lastAmmoCount = currentAmmo  
                lastWeaponHash = weapon 
            end

            if currentAmmo > lastAmmoCount then
                local ammoReloaded = currentAmmo - lastAmmoCount
                displayReloadNotification(ammoReloaded, currentAmmo)
            end

            lastAmmoCount = currentAmmo
        else
            if lastWeaponState == "drawn" then
                local currentAmmo = GetAmmoInPedWeapon(ped, lastWeaponHash)
                displayWeaponHolsteredNotification(currentAmmo)
                lastWeaponState = "holstered"
            end
        end
    end
end)
