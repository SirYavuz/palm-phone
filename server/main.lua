TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'telefonac', function(source, args, user)
  local xPlayer = ESX.GetPlayerFromId(source)
  local item    = xPlayer.getInventoryItem('phone').count
  if item > 0 then
  TriggerClientEvent('palmphone:open', source);
  TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Bildirim: Telefon komutla açıldı!'})

else
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Telefona sahip değilsin!'})
end
    
end, {help = "Telefonu açmak için kullanılır."})

TriggerEvent('es:addCommand', 'telefonkapat', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item    = xPlayer.getInventoryItem('phone').count
    if item > 0 then
    TriggerClientEvent('palmphone:close', source);
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Bildirim: Telefon komutla kapatıldı!'})
  
  else
       TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Telefona sahip değilsin!'})
  end
      
  end, {help = "Telefonu kapatmak için kullanılır."})



