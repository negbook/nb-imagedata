# nb-imagedata

To convert texture or remote-image-link(png/jpg/etc...) to base64 or runtimetexturebuffer&length

in Example.lua Supply Two commands to convert textures or images.
```
/url https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png --remote image png/jpg/etc...
/txd txd --game texture (CHAR_FACEBOOK/CHAR_DEFAULT)
/txd txd txn --game texture with dict and txname
```

Functions/Exports:

```
exports['nb-imagedata']:GetRemoteImageData(link,towidth,toheight,cb)
exports['nb-imagedata']:GetTextureData(txd,txn,towidth,toheight,cb)
```
```
cb = function(result)
print(
result.width		,	
result.height		,
result.buffer		,
result.bufferlength	,
result.base64		,
result.nuiurl		,
)
end
```