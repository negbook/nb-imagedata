local isDebug = true 
if isDebug then 
	function DrawIt(DebugRuntimeTextureBufferString,DebugRuntimeTextureBufferLength)
		CreateThread(function()
			local debugtxd = CreateRuntimeTxd("debugtxd")
			local debugrtxhandle = CreateRuntimeTexture(debugtxd, "texture",128, 128)
			while true do Wait(0)
				if DebugRuntimeTextureBufferLength>0 then 
					SetRuntimeTextureArgbData(
						debugrtxhandle --[[ long ]], 
						DebugRuntimeTextureBufferString --[[ string ]], 
						DebugRuntimeTextureBufferLength --[[ integer ]]
					)
					--CommitRuntimeTexture(rtxhandle)
					DrawSprite("debugtxd", "texture", 0.5, 0.5, 0.1, 0.1*GetAspectRatio(false), 0.0, 255, 255, 255, 255)
				end 
			end
		end)
	end
end 

RegisterCommand("url",function(source,args,rawCommand)
	exports['nb-imagedata']:GetRemoteImageData(args[1],128,128,function(result)
		print(result.length)
		print(result.base64)
		if isDebug then 
			DrawIt(result.buffer,result.length)
		end 
	end)
end,false)
RegisterCommand("txd",function(source,args,rawCommand)
	exports['nb-imagedata']:GetTextureData(args[1],args[2] or args[1],128,128,function(result)
		print(result.length,result.txd,result.txn)
		print(result.base64)
		if isDebug then 
			DrawIt(result.buffer,result.length)
		end 
	end)
end,false)