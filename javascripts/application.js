(function(){var a,b;b=function(){function a(a,b){this.radius=a,this.radians=b}return a.prototype.x=function(){return Math.cos(this.radians)*this.radius},a.prototype.y=function(){return Math.sin(this.radians)*this.radius},a}(),a=function(){function a(a){this.canvas=a,this.context=this.canvas.getContext("2d"),this.context.translate(this.canvas.width/2,this.canvas.height/2)}return a.prototype.go=function(a){var c,d,e,f,g,h;for(this.context.clearRect(-1*this.canvas.width,-1*this.canvas.height,2*this.canvas.width,2*this.canvas.height),this.context.beginPath(),f=144,e=h=0;f>=0?f>=h:h>=f;e=f>=0?++h:--h)d=e*a%f,g=new b(this.radius(),e/f*(2*Math.PI)),c=new b(this.radius(),d/f*(2*Math.PI)),this.context.moveTo(g.x(),g.y()),this.context.lineTo(c.x(),c.y());return this.context.stroke()},a.prototype.radius=function(){return this._radius||(this._radius=Math.floor(.9*Math.min(this.canvas.width,this.canvas.height)/2))},a}(),this.draw=function(){var b,c,d,e;return b=document.getElementById("prismatron"),b.getContext?(b.width=window.innerWidth,b.height=window.innerHeight,e=new a(b),c=document.getElementById("indicator"),this.factor=1,d=function(){return c.textContent=Math.ceil(100*this.factor)/100,e.go(this.factor),this.factor=this.factor+.01},setInterval(d,10)):void 0}}).call(this);
