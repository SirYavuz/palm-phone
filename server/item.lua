local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    ESX.RegisterServerCallback('palmphone:itemsorgula', function(source, cb, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)

ESX.RegisterUsableItem('powerbank', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('powerbank', 1)
	TriggerClientEvent('power:bank')

end)



RegisterServerEvent('telefon:yok')
AddEventHandler('telefon:yok', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Telefona sahip değilsin!'})

end)

RegisterServerEvent('sinyal:yok')
AddEventHandler('sinyal:yok', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı:Sinyal çekmeyen bir bölgedesin!'})
end)

RegisterServerEvent('charge:down')
AddEventHandler('charge:down', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Şarj: %1 azaldı!'})
end)

RegisterServerEvent('charge:upnotif')
AddEventHandler('charge:upnotif', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Şarj: %1 arttı!'})
end)

RegisterServerEvent('bank:transferTimeNotif')
AddEventHandler('bank:transferTimeNotif', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Bu saatte transfer yapamazsınız!'})
end)

RegisterServerEvent('charge:start')
AddEventHandler('charge:start', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Telefonunu şarja taktın!'})
end)

RegisterServerEvent('charge:notcar')
AddEventHandler('charge:notcar', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Araçta değilsin!'})
end)

RegisterServerEvent('charge:notcable')
AddEventHandler('charge:notcable', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Sarj Kablon yok!'})
end)

RegisterServerEvent('water:inside')
AddEventHandler('water:inside', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Suyun içerisinde telefon kullanamazsın!'})
end)



