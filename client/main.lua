local ActiveRecoil = false

Citizen.CreateThread(function()
    if Config.CustomDamage then
        for weapon, data in pairs(Config.Weapons) do
            SetWeaponDamageModifier(weapon, data.Damage)
        end
    end

    if Config.ClassicRecoil then
        for weapon, data in pairs(Config.Weapons) do
            SetWeaponRecoilShakeAmplitude(GetHashKey(weapon), data.ClassicRecoil)
        end
    end

    if Config.RealisticFlashLight then
        SetFlashLightKeepOnWhileMoving(true)
    end
end)

Citizen.CreateThread(function()
    while Config.HideCrossHair do
        Citizen.Wait(1)
        local isArmed = IsPedArmed(PlayerPedId(), 6)
        
        if isArmed then
            HideHudComponentThisFrame(14)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while Config.DisableHeadShots do
        Citizen.Wait(5000)
        SetPedSuffersCriticalHits(PlayerPedId(), false)
    end
end)

Citizen.CreateThread(function()
    while Config.RemovePistolWhipping do
        Citizen.Wait(15)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while Config.DrunkRecoil do
        Citizen.Wait(150)

        local isArmed = IsPedArmed(PlayerPedId(), 6)
        if isArmed then
            local currentWeapon = nil
            local _, weapon = GetCurrentPedWeapon(PlayerPedId())

            for weaponName, data in pairs(Config.Weapons) do
                if GetHashKey(weaponName) == weapon then
                    currentWeapon = weaponName
                    break
                end
            end
            
            if currentWeapon and Config.Weapons[currentWeapon].DrunkRecoil ~= 0 then
                local playerPed = PlayerPedId()
                local isAimingOrShooting = IsPlayerFreeAiming(PlayerId()) or IsPedShooting(playerPed)

                if isAimingOrShooting then
                    if not ActiveRecoil then
                        ActiveRecoil = true
                        ShakeGameplayCam("DRUNK_SHAKE", Config.Weapons[currentWeapon].DrunkRecoil)
                    end
                elseif ActiveRecoil then
                    ActiveRecoil = false
                    Citizen.Wait(150)
                    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)
