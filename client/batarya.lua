-- ESX = nil

-- local batarya = 50

-- Citizen.CreateThread(function ()
-- 	while true do
-- 		Citizen.Wait(2000)-- yenileme süresi
-- 		if batarya > 1 then
-- 			Citizen.Wait(5000) -- ne kadar sürede şarj azalsın
-- 			TriggerServerEvent("yavuz:bataryaupdate")
-- 			ESX.ShowNotification("Şarjın 1 azaldı")
-- 		else
-- 			DisableControlAction(0, teclatele, true) -- Telefonu kapatma 
-- 			ESX.ShowNotification("Telefon kapandı")
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('yavuz:bataryaupdate')
-- AddEventHandler('yavuz:bataryaupdate', function()
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	-- local batarya = 50
-- 	batarya = batarya - 50
-- end)