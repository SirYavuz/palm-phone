
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local onPhone = false
local isLoggedIn = false
local telefonTusu = 288
local batarya = 50
local muzikdurumu = 2
local maxBatarya = 100
local yuzenoyuncu = PlayerPedId()
local PlaySound = false


ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('palmphone:itemsorgula', function(qtty)
    cb(qtty > 0)
  end, 'phone')
end

function hasCable (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('palmphone:itemsorgula', function(qtty)
    cb(qtty > 0)
  end, 'chargecable') -- chargecable
end


function telefonYok () 
  if (ESX == nil) then return end
  TriggerServerEvent('telefon:yok')
  TriggerEvent("lanet")
end

-- telefon yok iken animasyon
RegisterNetEvent( 'lanet' )
AddEventHandler( 'lanet', function()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict( "gestures@m@standing@casual" ) 
    TaskPlayAnim( GetPlayerPed(-1), "gestures@m@standing@casual", "gesture_damn", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(GetPlayerPed(-1))
end)
-- telefonu açma,  item sorgulama, sinyal sorgulama


 Citizen.CreateThread(function()
	while true do
    Citizen.Wait(0)

	  if takePhoto ~= true then
        if IsControlJustPressed(1, Config.telefonTusu) then	
          hasPhone(function (hasPhone)
            if hasPhone == true then            
               telefonAc(true) 
            else
              telefonYok()
            end
          end)
        end
      end
      end
 
 end)

 Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/c', 'Yürürken Telefon aramasına devam edebilmek için kullanabilirsiniz.')
  TriggerEvent('chat:addSuggestion', '/h', 'Telefon aramasını kapatmak için kullanılır.')
  TriggerEvent('chat:addSuggestion', '/a', 'Gelen Telefon aramasını açmak için kullanılır.')
 end)


function telefonAc(bool)

   PhonePlayIn()
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "phone",
        toggle = bool
    })
    onPhone = bool 
end

RegisterCommand('c', function(bool)
  SetNuiFocus(bool, bool)
end)

local client_yemek_gorev = false
RegisterCommand('yemekbasla', function()
    if client_yemek_gorev == false then 
      client_yemek_gorev = true
      TriggerServerEvent('yemek-gorevi')
    else 
      TriggerServerEvent('yemek-gorevi')
      client_yemek_gorev = false
    end
end)

RegisterNetEvent('yemek-onaylandi-gir')
AddEventHandler('yemek-onaylandi-gir', function(gelenadres, gelenyemek)
  Citizen.Wait(5000)
  ESX.ShowNotification('Gelen Adres Client')
end)


RegisterCommand('h', function(bool)
  exports['mythic_notify']:DoLongHudText('inform', 'Arama kapatıldı ')
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "aramakapat",
    toggle = bool
})
end)

function itemKontrol()
	telefonAc(true)
end

--Telefon kapatma eventi
RegisterNUICallback('exit', function()
    telefonAc(false)
    PhonePlayAnim('out')
end)

RegisterNUICallback('gelenadres', function(data)
  local gelenadres = data.gonderilenadres 
  local gelenyemek = data.gonderilensiparis
  TriggerServerEvent('siparis-server-kontrol', gelenadres, gelenyemek)
end)

RegisterNUICallback('ayarlar-resim-yukle', function(data)
  local resim = data.resim_url
  print('client url : ' ..resim)
  TriggerServerEvent('ayarlar_resim_yukle', resim)
end)

RegisterNUICallback('opencamera', function(data, cb)
	SendNUIMessage({show = false})
  cb()
  telefonAc(false)
  Citizen.Wait(500)
	TriggerEvent('camera:open')
  end)

  RegisterNUICallback('gorevapp', function(data, cb)
	SendNUIMessage({show = false})
  cb()
  TriggerServerEvent('duty:onoff')  
  end)



  RegisterNUICallback('uberbasla', function(data, cb)
	SendNUIMessage({show = false})
  cb()
  TriggerEvent('yavuz:uberbasla')  
  end)

  RegisterNUICallback('taksigetir', function(data, cb)
	SendNUIMessage({show = false})
  cb()
  TriggerEvent('yavuz:taksi')  
  end)
 
  RegisterNUICallback('ihbar', function(data, cb)
  SendNUIMessage({show = false})
  ihbar()
  cb()
  end)

  RegisterNUICallback('aramayapanim', function()
    SendNUIMessage({show = false})
    PhonePlayAnim('call')
  
    end)
    
  RegisterNUICallback('aramakapatanim', function()
    SendNUIMessage({show = false})
    PhonePlayAnim('out')
    PhonePlayIn()

    end)


  ---- BANKA ----
  RegisterNUICallback('paragetir', function(data, cb)
    TriggerServerEvent('para:yazdir')
  end)
 

  RegisterNetEvent('banka:parasi')
  AddEventHandler('banka:parasi', function(serverparasi)
      SendNUIMessage({type = 'updateMoney', money = serverparasi})
  end)
  
  RegisterNUICallback('idgetir', function(data, cb)
    local playerid =  GetPlayerServerId(PlayerId())
    SendNUIMessage({type = 'updateId', id = playerid})
  end)
 

  RegisterNUICallback('isimgetir', function(data, cb)
    ESX.TriggerServerCallback('new_banking:getCharacterName', function(data)
      local name = data.firstname.. ' ' ..data.lastname
      SendNUIMessage({
        type = "updateName",
        isim = name
        })
    end)
  end)
  
  RegisterNUICallback('ayarlar-isim-getir', function(data, cb)
    ESX.TriggerServerCallback('new_banking:getCharacterName', function(data)
      local name = data.firstname.. ' ' ..data.lastname
      SendNUIMessage({
        type = "updateNameSettings",
        isim = name
        })
    end)
  end)
  
  RegisterNUICallback('ayarlar-numara-getir', function(data, cb)
    ESX.TriggerServerCallback('palm-phone-numara-getir', function(data)
      local numara = data.phone_number
      print(numara)
      SendNUIMessage({
        type = "updateNumaraSettings",
        numara = numara
        })
    end)
  end)
  
  RegisterNUICallback('ayarlar-resim-getir', function(data, cb)
    ESX.TriggerServerCallback('palm-phone-resim-getir', function(data)
      local resim = data.profil_resmi
      print(resim)
      SendNUIMessage({
        type = "updateResimSettings",
        resim = resim
        })
    end)
  end)

  RegisterNUICallback('ayarlar-paket-getir', function(data, cb)
    ESX.TriggerServerCallback('palm-phone-paket-getir', function(data)
      local paket = data.telefon_paketi
      print(resim)
      SendNUIMessage({
        type = "updatePaketSettings",
        paket = paket
        })
    end)
  end)
 
  RegisterNUICallback('aramakapatmasesi', function(data, cb)
      SendNUIMessage({transactionType = 'playSound'})
  end)


  ---- BANKA ----

--Komutla telefonu açma yeri
RegisterNetEvent('palmphone:open')
AddEventHandler('palmphone:open', function()
	telefonAc(true)
end)

--Komutla telefonu kapatma yeri
RegisterNetEvent('palmphone:close')
AddEventHandler('palmphone:close', function()
	telefonAc(false)
	PhonePlayAnim('out')
end)


-- Saat Hesaplama

function CalculateTimeToDisplay()
	hour = GetClockHours()
    minute = GetClockMinutes()
    
    local obj = {}

    if hour <= 12 then
        obj.ampm = ''
    elseif hour >= 13 then
        obj.ampm = ''
        -- hour = hour - 12
    end
    
	if minute <= 9 then
		minute = "0" .. minute
    end
    
    obj.hour = hour
    obj.minute = minute

    return obj
end

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(500)
--         if onPhone then
--             local time = CalculateTimeToDisplay()
--             SendNUIMessage({
--                 type = "updateTime",
--                 time = time
--             })
--         end
--     end
-- end)


--BANKA


RegisterNUICallback('transfer', function(data)

  if hour < Config.TransferNightTime  then 
    if hour >= Config.TransferMorningTime then
  TriggerServerEvent('banka:transfer', data.to, data.amountt)
  --ESX.ShowNotification("Aşama 1 başarılı")
   TriggerServerEvent('bank:balance')
  else 
    TriggerServerEvent('bank:transferTimeNotif')
  end
else 
  TriggerServerEvent('bank:transferTimeNotif')
end
end)


RegisterNUICallback('arananbildirim', function(data)
  local kim = data.number 
  exports['mythic_notify']:DoLongHudText('inform', 'Aranan Numara ['..kim..'] ')
  TriggerServerEvent('yavuz:arama:baslat', data.number)
    end)




  Citizen.CreateThread(function()
      while true do
        Citizen.Wait(0)
        if onPhone then
          local time = CalculateTimeToDisplay()
          SendNUIMessage({
              type = "updateTime",
              time = time
          })
      end
    end
  end)
  

--Sinyal

function sinyalBoz()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.SignalArea) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.SignalDistance then
			return true
    end

  end
end

--  Citizen.CreateThread(function()
-- 	while true do
-- 	  Citizen.Wait(0)
-- 	  if takePhoto ~= true then
--         if IsControlJustPressed(1, Config.telefonTusu) then	
--           hasPhone(function (hasPhone)
--             if hasPhone == true then
--                 TriggerEvent('sinyal:kontrol')
--                 chargeDown()
--                 chargeControl()
--             else
--                 telefonYok()
--             end
--             end)
--         end
--       end
--       end
--  end)


 
--  Citizen.CreateThread(function()
-- 	while true do
--     Citizen.Wait(0)
--     if IsControlJustPressed(1, Config.telefonTusu) then	
--       if IsEntityInWater(yuzenoyuncu) and IsPedSwimming(yuzenoyuncu) then     		  
--                   telefonAc(false)
--                 --  ESX.ShowNotification("sudasın")
                  
--           end
--         end
--       end
--  end)
 

-- RegisterNetEvent( 'sinyal:kontrol' )
-- AddEventHandler( 'sinyal:kontrol', function()
--   while true do 
--     Citizen.Wait(Config.SignalRefreshTime)
--     if sinyalBoz() then 
--       TriggerServerEvent('sinyal:yok')
--      -- TriggerEvent("lanet")
--       telefonAc(false)
--       Citizen.Wait(800)
--       ClearPedTasks(GetPlayerPed(-1))
--     else
       
--     end
--   end
-- end)



RegisterNUICallback('bankaismi', function(data, cb)
  TriggerServerEvent('banka:ismi:ver')
end)



-- RegisterNetEvent('banka:ismi:gitti')
-- AddEventHandler('banka:ismi:gitti', function(balance)
-- 	ESX.TriggerServerCallback('banka:ismiver', function(data)
-- 		local name = data.firstname.. ' ' ..data.lastname
-- 		SendNUIMessage({
-- 			type = "updateName",
-- 			balance = balance,
-- 			player = name
-- 			})
-- 	end)
-- end)






-- ŞARJ SİSTEMİ
--  function chargeControl()
--   if batarya <= 0 then 
    
--     DisableControlAction(0, teclatele, true)
--     TriggerEvent("lanet")
--     ESX.ShowNotification("Şarjın yok")
--      -- Şarj kapatma seviyesinin altına düşerse telefon kendini kapatır
--   else
--     telefonAc(true)
--   end
-- end


-- Sarj Noktası
-- function chargeUpArea()
-- 	local player = GetPlayerPed(-1)
-- 	local playerloc = GetEntityCoords(player, 0)

-- 	for _, search in pairs(Config.ChargePoint) do
-- 		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

--     if distance <= Config.ChargeAreaDistance then
--    --   DrawMarker(Config.Type, 325.98, -197.97, 54.23, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				
-- 			return true
--     end

--   end
-- end

-- function chargeMarker()
-- 	local player = GetPlayerPed(-1)
-- 	local playerloc = GetEntityCoords(player, 0)

-- 	for _, search in pairs(Config.ChargePoint) do
-- 		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

--     if distance <= Config.ChargeAreaDistance then
      
--       DrawMarker(Config.Type, 325.98, -197.97, 54.23, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
     
-- 			return true
--     end

--   end
-- end


  --   local player = GetPlayerPed(-1)
  --   local playerloc = GetEntityCoords(player, 0)

  --   for _, search in pairs(Config.ChargePoint) do
	-- 		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

	-- 			if distance <= Config.ChargeAreaDistance then
  --      --   DrawMarker(Config.Type, 325.98, -197.97, 53.23, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
  --     --    DrawText3D(325.98, -197.97, 54.23, "Sarj etmek icin ~r~[E]", 0.5)
  --         --şirket
  --         DrawMarker(Config.Type, -1578.85, -580.65, 107.53, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
  --         DrawText3D(-1578.85, -580.65, 108.52, "Sarj etmek icin ~r~[E]", 0.5)
  --       end
  --       if distance <= Config.ChargeAreaDistance then
          
  --         if IsControlJustPressed(1, 38) then
  --           hasCable(function (hasCable)
  --             if hasCable == true then
  --             TriggerServerEvent('charge:start')
  --         else
  --          TriggerServerEvent('charge:notcable')
  --          TriggerEvent("lanet")
  --       end
  --     end)
  --  end
	-- 		end
  --     end

-- hasCable(function (hasCable)
--   if hasCable == true then

-- Citizen.CreateThread(function()
--   while true do
--     Wait(0)
--       if chargeUpArea() then
--       if IsControlJustPressed(1, 38) then
--         chargeUp()
--         ESX.ShowNotification("Şarj doldurma yerine uzaksınız")
--         TriggerServerEvent('charge:upnotif')
--       end
--     end
--   end
-- end)


-- function chargeDown()
--   batarya = batarya - Config.ChargeDownSpeed
-- end

-- function chargeUp()
--   while true do
--     Citizen.Wait(1000)
--     if chargeUpArea() then
--       if batarya >= 100 then
--         batarya = 100
--       else
--   batarya = batarya + 1
--   end
-- end
-- end
-- end

-- function CarChargeUp()
--   while true do
--     Citizen.Wait(Config.CarChargeSpeed)
--   if batarya >= 100 then
--      batarya = 100
--   else
--      batarya = batarya + 1
--   end
-- end
-- end


-------------------------------------------
----      [[      KOMUTLAR     ]]      ----
-------------------------------------------

RegisterCommand('batarya', function()
  ESX.ShowNotification("Batarya durumu : %" ..batarya.. "")
end)



-------------------------------------------
----      [[      ZIL SESİ     ]]      ----
-------------------------------------------

-- Citizen.CreateThread(function()
--   while true do
--       Citizen.Wait(10)
--       if zilalani == true then
--         if muzikdurumu == 1 then
--            -- ESX.ShowNotification("Zaten muzik çalıyor")
--         else
--           zilbaslat()
--         end
--       else
--         zildurdur()
--       end
--   end
-- end)

-- Citizen.CreateThread(function()
--   while true do
--       Citizen.Wait(10)
--       ringtoneArea()
--   end
-- end)

-- function ringtoneArea()
-- 	local player = GetPlayerPed(-1)
-- 	local playerloc = GetEntityCoords(player, 0)

-- 	for _, search in pairs(Config.RingtoneArea) do
-- 		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

--     if distance <= 25 then
--    			zilalani = true
--       return true
--     else 
--       zilalani = false
--       muzikdurumu = 2
--     end

--   end
-- end

function zilbaslat()
  SendNUIMessage({transactionType = 'playSound'})
  PhonePlayCall()
  muzikdurumu = 1
end



function zildurdur()
  SendNUIMessage({transactionType = 'stopSound'})
  PhonePlayAnim('out')
end

RegisterCommand('zilbaslat', function() zilbaslat() end)
RegisterCommand('zildurdur', function() zildurdur() end)
RegisterCommand('mesaj', function() PhonePlayText() end)

-- 3D Yazı yazdırmak için gerekli function
function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end



function aractayim()
  local player = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(player, false)
  hasCable(function (hasCable)
    if hasCable == true then
  if IsPedInAnyVehicle(player, false) then
    --  ESX.ShowNotification('selamke')
      TriggerServerEvent('charge:start')
      CarChargeUp()
  else
   -- ESX.ShowNotification('aracta degilsin ki moruq')
    TriggerServerEvent('charge:notcar')
  end
else
 -- ESX.ShowNotification('Kablon yok')
  TriggerServerEvent('charge:notcable')
end
end)
end


RegisterCommand('aracsarj', function()
  aractayim()
end)


-- arama kısmı

RegisterNUICallback('arama', function(data, cb)
  TriggerEvent('arama:kanali')
  SetNuiFocus(bool, bool)
 end)

 RegisterNetEvent('arama:kanali')
 AddEventHandler('arama:kanali', function()
  local _source = source
  local PlayerData = ESX.GetPlayerData(_source)
  local playerName = GetPlayerName(PlayerId())
  local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
  local channel =  math.random(Config.CallStartRoom, Config.CallStopRoom)
   
  exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
  exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(channel), true);
  exports.tokovoip_script:addPlayerToRadio(tonumber(channel))

 end)

 local sesdurum = false

 RegisterCommand('aramasesi', function()
  if not sesdurum then
    TriggerEvent('gcPhone:TgiannSes')
  else
    TriggerEvent('gcPhone:stop-call-sound')
  end
 end)


 Citizen.CreateThread(function()

  TriggerServerEvent('database-kayit')
 

  end)

  RegisterNUICallback('fatura_getir', function(data)
    ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
      local elements = {}
      for i=1, #bills, 1 do
         local faturam = bills[i].id.. ' ' ..bills[i].label
        --  print(faturam)
        SendNUIMessage({
          type = "fatura_yukle",
          faturaid = bills[i].id,
          faturaaciklamasi = bills[i].label,
          faturafiyati = bills[i].amount
          })
      end
     
    end)
  end)
  

  -- RegisterNetEvent('deneme-fatura')
  -- AddEventHandler('deneme-fatura', function()
  --   ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
  --     local elements = {}
  --     for i=1, #bills, 1 do
  --       -- table.insert(elements, {
  --       --   label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, 'asdasd', ESX.Math.GroupDigits(bills[i].amount))),
  --       --   billID = bills[i].id
  --       -- })
  --        local faturam = bills[i].id.. '' ..bills[i].label
  --       --  print(faturam)
  --       SendNUIMessage({
  --         type = "fatura_yukle",
  --         faturajs = faturam 
  --         })
  --     end
     
  --   end)
  -- end)
  
  RegisterNUICallback('pcell-paket-yukle', function(data)
    local pcell_paket = data.paket
      TriggerServerEvent('pcell-paket-upload', pcell_paket)
  end)
  

  RegisterNUICallback('pcell-guncelle', function(data, cb)
    ESX.TriggerServerCallback('pcell-bilgiler1', function(data)
      local tel_paket = data.telefon_paketi
      SendNUIMessage({
        type = "pcell-guncelleme2",
        paket = tel_paket
        })
    end)
    
    ESX.TriggerServerCallback('pcell-bilgiler2', function(data)
      local isim = data.firstname.. ' ' ..data.lastname
      local tel_no = data.phone_number
    
      SendNUIMessage({
        type = "pcell-guncelleme",
         isim = isim,
         numara = tel_no

        })
    end)
  end)
  