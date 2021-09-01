local Callbacks = {}
local CallbackId = 1


GetTextureData = function(txd,txn,width,height,cb)
	Callbacks[CallbackId] = function(data)
		local buffer = data.buffer
		local bufferstring = {}
		for i=1,#buffer do 
			table.insert(bufferstring,string.char(buffer[i]))
		end 
		local RuntimeTextureBufferString = table.concat(bufferstring)
		--local RuntimeTextureBufferLength = 4*data.width* data.height
		cb({
			buffer = RuntimeTextureBufferString,
			length = data.bufferlength,
			base64 = data.base64,
			width = data.width,
			height = data.height,
			txd = txd,
			txn = txn
		})
		Callbacks[CallbackId] = nil
		
	end 
	if not HasStreamedTextureDictLoaded(txd) then 
		RequestStreamedTextureDict(txd)
		repeat Wait(0) until HasStreamedTextureDictLoaded(txd)
	end 
	SendNUIMessage({
			action = 'convertTexture',
			txd = txd,
			txn = txn,
			width = width,
			height = height,
			callbackid = CallbackId
	})
	CallbackId = CallbackId + 1
	if CallbackId > 65530 then 
		CallbackId = 1 
	end 
end 
GetRemoteImageData = function(url,width,height,cb)
	Callbacks[CallbackId] = function(data)
		local buffer = data.buffer
		local bufferstring = {}
		for i=1,#buffer do 
			table.insert(bufferstring,string.char(buffer[i]))
		end 
		local RuntimeTextureBufferString = table.concat(bufferstring)
		--local RuntimeTextureBufferLength = 4*data.width* data.height
		cb({
			buffer = RuntimeTextureBufferString,
			length = data.bufferlength,
			base64 = data.base64,
			width = data.width,
			height = data.height
		})
		Callbacks[CallbackId] = nil
		
	end 
	SendNUIMessage({
			action = 'convertRemoteImage',
			url = url,
			width = width,
			height = height,
			callbackid = CallbackId
	})
	CallbackId = CallbackId + 1
	if CallbackId > 65530 then 
		CallbackId = 1 
	end 
end 
exports("GetTextureData",GetTextureData)
exports("GetRemoteImageData",GetRemoteImageData)
RegisterNUICallback('imagedatabuffer', function(data,cb)
	print(data.nuiurl)
	if data and data.callbackID then 
		Callbacks[data.callbackID](data)
	end 
	cb('ok')
end)
