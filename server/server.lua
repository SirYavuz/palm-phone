ESX                       = nil
local DisptachRequestId   = 0
local PhoneNumbers        = {}

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)



--numara verme yeri
function numaraVer()

  local foundNumber = false
  local phoneNumber = nil

  while not foundNumber do

    math.randomseed(GetGameTimer())
		phoneNumber = "91" .. math.random(0000000, 9999999)

    local result = MySQL.Sync.fetchAll(
      'SELECT COUNT(*) as count FROM users WHERE phone_number = @phoneNumber',
      {
        ['@phoneNumber'] = phoneNumber
      }
    )

    local count  = tonumber(result[1].count)

    if count == 0 then
      foundNumber = true
    end

  end

  return phoneNumber
end

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('ayarlar_resim_yukle')
AddEventHandler('ayarlar_resim_yukle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

end)



RegisterServerEvent('arama:bildirim')
AddEventHandler('arama:bildirim', function(aranan)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(aranan)
    TriggerClientEvent('esx:showAdvancedNotification', _source,'Telefon', 'Arıyorsun','','CHAR_BANK_MAZE', 9)
    TriggerClientEvent('esx:showAdvancedNotification', aranan, 'Telefon','Telefonun çalıyor', '', 'CHAR_BANK_MAZE', 9)


end)

RegisterServerEvent("arama:geldibildirim")
AddEventHandler("arama:geldibildirim", function(aranan)
 -- ..GetPlayerName(target)..
 --TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Uyarı: Arama başlatıldı. Aranan kişi: ' ..GetPlayerName(aranan).. ' aranıyor'})
  TriggerClientEvent('mythic_notify:client:SendAlert', aranan, {type = 'inform', text = 'Uyarı: Telefonun çalıyor.Kabul etmek için [Y] Reddetmek için [N] bas!'})
 end)

RegisterServerEvent('arama:gittibildirim')
AddEventHandler('arama:gittibildirim', function()
  TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Uyarı: Arama başlatıldı.'})
 end)

RegisterServerEvent('arama:kapatmabildirim')
AddEventHandler('arama:kapatmabildirim', function()
  TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Uyarı: Arama kapatıldı!'})
end)

RegisterServerEvent('arama:degilsin')
AddEventHandler('arama:degilsin', function()
  TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Bir çağrıda bulunmuyorsun!'})
end)

RegisterServerEvent('arama:mevcud')
AddEventHandler('arama:mevcud', function()
  TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Zaten bir çağrıdasın!'})
end)

-- RegisterServerEvent('aranma:bildirimi')
-- AddEventHandler('aranma:bildirimi', function(aranan)
--   local _source = source
--   local xPlayer = ESX.GetPlayerFromId(_source)
--   local zPlayer = ESX.GetPlayerFromId(aranan)
--     TriggerClientEvent('mythic_notify:client:SendAlert', aranan, {type = 'error', text = 'Uyarı: Telefona sahip değilsin!'})
--     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Telefona sahip değilsin!'})

-- end)



RegisterServerEvent('banka:transfer')

AddEventHandler('banka:transfer', function(to, amountt)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
   

    local zPlayer = ESX.GetPlayerFromId(to)

    local balance = 0

    if zPlayer ~= nil then

        balance = xPlayer.getAccount('bank').money

        zbalance = zPlayer.getAccount('bank').money

        if tonumber(_source) == tonumber(to) then

            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank','Transfer Money', 'Kendine transfer yapamazsın!','CHAR_BANK_MAZE', 9)

        else

            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=0 then

                TriggerClientEvent('esx:showAdvancedNotification', _source,'Bank', 'Transfer Money','Transfer yapacak kadar paran yok!','CHAR_BANK_MAZE', 9)

            elseif amountt >= '10000' then
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                local yenideger = tonumber(amountt) * 0.95
                zPlayer.addAccountMoney('bank', tonumber(yenideger))
                TriggerClientEvent('esx:showAdvancedNotification', _source,'Bank', 'Transfer Money', 'Şu kadar transfer ettin ~r~$' .. yenideger ..'~s~ to ~r~' .. to .. ' .','CHAR_BANK_MAZE', 9)

                TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank','Transfer Money', 'Şu kadar aldın~r~$' .. yenideger .. '~s~ from ~r~' .. _source ..' .', 'CHAR_BANK_MAZE', 9)

              else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))

                TriggerClientEvent('esx:showAdvancedNotification', _source,'Bank', 'Transfer Money','Şu kadar transfer ettin ~r~$' .. amountt .. '~s~ to ~r~' .. to .. ' .','CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank','Transfer Money', 'Şu kadar aldın~r~$' .. amountt .. '~s~ from ~r~' .. _source ..' .', 'CHAR_BANK_MAZE', 9)

            end
        end
    end
end)

RegisterServerEvent('ayarlar_resim_yukle')
AddEventHandler('ayarlar_resim_yukle', function(resim)
  print(resim)
  -- local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetPlayerIdentifiers(source)[1]

  MySQL.Async.execute('UPDATE palm_phone SET profil_resmi = @profil_resmi WHERE identifier = @identifier', {
    ['@profil_resmi']= resim,
    ['@identifier'] = identifier
  })

end)



RegisterNetEvent('para:yazdir')
AddEventHandler('para:yazdir', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  serverparasi = xPlayer.getAccount('bank').money
  TriggerClientEvent('banka:parasi', _source, serverparasi)
end)



RegisterNetEvent('siparis-server-kontrol')
AddEventHandler('siparis-server-kontrol', function (gelenadres, gelenyemek)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  TriggerClientEvent('esx:showAdvancedNotification', source, 'Emeksepeti','Sipariş geldi Adres : '..gelenadres..' Yemek : ' ..gelenyemek.. '', '', 'CHAR_BANK_MAZE', 9)
  
  if server_yemek_gorev == true then
  TriggerClientEvent('yemek-onaylandi-gir', source, gelenadres, gelenyemek)
    
  end
end)

local server_yemek_gorev = false 
RegisterServerEvent('yemek-gorevi')
AddEventHandler('yemek-gorevi', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
  if server_yemek_gorev == false then
    server_yemek_gorev = true
  else 
    server_yemek_gorev = false
  end
end)



RegisterServerEvent('yavuz:arama:baslat')
AddEventHandler('yavuz:arama:baslat', function(number)

    local _source     = source
  local xPlayer     = ESX.GetPlayerFromId(_source)
  local xPlayers    = ESX.GetPlayers()
  local channel     = _source + 1000
  local foundPlayer = false

  for i=1, #xPlayers, 1 do

    local targetXPlayer = ESX.GetPlayerFromId(xPlayers[i])

    if targetXPlayer.get('phoneNumber') == tonumber(number) then
      foundPlayer = targetXPlayer
      break
    end

  end

end)


ESX.RegisterServerCallback('palm-phone-numara-getir', function(source, cb)
  local identifier = GetPlayerIdentifiers(source)[1]
  print(identifier)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
      ['@identifier'] = identifier
  }, function(result)
      cb({phone_number = result[1].phone_number})
  end)
end)

ESX.RegisterServerCallback('palm-phone-resim-getir', function(source, cb)
  local identifier = GetPlayerIdentifiers(source)[1]
  print(identifier)
  MySQL.Async.fetchAll('SELECT * FROM palm_phone WHERE identifier=@identifier', {
      ['@identifier'] = identifier
  }, function(result)
      cb({profil_resmi = result[1].profil_resmi})
  end)
end)

ESX.RegisterServerCallback('palm-phone-paket-getir', function(source, cb)
  local identifier = GetPlayerIdentifiers(source)[1]
  print(identifier)
  MySQL.Async.fetchAll('SELECT * FROM palm_phone WHERE identifier=@identifier', {
      ['@identifier'] = identifier
  }, function(result)
      cb({telefon_paketi = result[1].telefon_paketi})
  end)
end)

RegisterServerEvent('database-kayit')
AddEventHandler('database-kayit', function()
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT * FROM palm_phone WHERE identifier=@identifier', {
    ['@identifier'] = identifier
}, function(result)
  if (result[1] ~= nil) then

  else 
    MySQL.Async.execute('INSERT INTO palm_phone (identifier) VALUES (@identifier)',
    {
      ['@identifier']  = identifier
    }, function()
    end)
   
  print("[Palm-Phone] Database'ye kişi kaydedildi hex : " ..identifier)
  end
end)
end)

RegisterServerEvent('pcell-paket-upload')
AddEventHandler('pcell-paket-upload', function(pcell_paket)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.execute('UPDATE palm_phone SET telefon_paketi = @telefon_paketi WHERE identifier = @identifier', {
    ['@telefon_paketi'] = pcell_paket,
    ['@identifier'] = identifier
})
end)


ESX.RegisterServerCallback('pcell-bilgiler1', function(source, cb)
  local identifier = GetPlayerIdentifiers(source)[1]
  
  MySQL.Async.fetchAll('SELECT * FROM palm_phone WHERE identifier=@identifier', {
      ['@identifier'] = identifier
  }, function(result)
    cb({telefon_paketi = result[1].telefon_paketi})
  end)
end)

ESX.RegisterServerCallback('pcell-bilgiler2', function(source, cb)
  local identifier = GetPlayerIdentifiers(source)[1]
  
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
      ['@identifier'] = identifier
  }, function(result)
    cb({ firstname = result[1].firstname, lastname = result[1].lastname, phone_number = result[1].phone_number,  })
  end)
end)

ESX.RegisterServerCallback('fatura-test', function(source, cb)
  MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end

		cb(bills)
  end)
end)


