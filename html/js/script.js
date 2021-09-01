window.addEventListener('message', (event) => {
    if (event.data.action == "convertTexture") {
		let txd = event.data.txd;
		let txn = event.data.txn;
		let url = 'https://nui-img/' + txd + '/' + txn + '?id=' + String(event.data.callbackid);
		let img = new Image();
		img.onload = function() {
			let canvas = document.createElement('canvas');
			let ctx = canvas.getContext('2d');
			canvas.height = event.data.height;
			canvas.width = event.data.width;
			ctx.scale(event.data.width/img.naturalWidth, event.data.height/img.naturalHeight);
			ctx.drawImage(img, 0, 0);
			let Buffer = ctx.getImageData(0, 0, canvas.width, canvas.height).data;
			let runtimetexturebuffer = [];
			for (let i=0;i<Buffer.length;i+=4) 
			{
				runtimetexturebuffer.push(Buffer[i+2]) ;
				runtimetexturebuffer.push(Buffer[i+1]) ;
				runtimetexturebuffer.push(Buffer[i+0]) ;
				runtimetexturebuffer.push(Buffer[i+3]) ;
			};
			let base64Url = canvas.toDataURL();
			console.log(base64Url);//nui debug tools
			$.post('http://nb-imagedata/imagedatabuffer', JSON.stringify({
				width: canvas.width ,
				height: canvas.height ,
				buffer: runtimetexturebuffer,
				bufferlength: 4*canvas.width *canvas.height,
				base64: base64Url,
				nuiurl: url,
				callbackID: event.data.callbackid
			}));
			img = null;
			canvas = null;
			ctx = null;
		};
		img.src = url;
	}
	else if (event.data.action == "convertRemoteImage") {
		let url = event.data.url;
		let img = new Image();
		img.onload = function() {
			let canvas = document.createElement('canvas');
			let ctx = canvas.getContext('2d');
			canvas.height = event.data.height;
			canvas.width = event.data.width;
			ctx.scale(event.data.width/img.naturalWidth, event.data.height/img.naturalHeight);
			ctx.drawImage(img, 0, 0);
			let Buffer = ctx.getImageData(0, 0, canvas.width, canvas.height).data;
			let runtimetexturebuffer = [];
			for (let i=0;i<Buffer.length;i+=4) 
			{
				runtimetexturebuffer.push(Buffer[i+2]) ;
				runtimetexturebuffer.push(Buffer[i+1]) ;
				runtimetexturebuffer.push(Buffer[i+0]) ;
				runtimetexturebuffer.push(Buffer[i+3]) ;
			};
			let base64Url = canvas.toDataURL();
			console.log(base64Url);//nui debug tools
			$.post('http://nb-imagedata/imagedatabuffer', JSON.stringify({
				width: canvas.width ,
				height: canvas.height ,
				buffer: runtimetexturebuffer,
				bufferlength: 4*canvas.width *canvas.height,
				base64: base64Url,
				nuiurl: url,
				callbackID: event.data.callbackid
			}));
			img = null;
			canvas = null;
			ctx = null;
		};
		img.src = url;
	}
});