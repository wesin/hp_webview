(function(t){function e(e){for(var n,a,c=e[0],u=e[1],i=e[2],p=0,f=[];p<c.length;p++)a=c[p],Object.prototype.hasOwnProperty.call(o,a)&&o[a]&&f.push(o[a][0]),o[a]=0;for(n in u)Object.prototype.hasOwnProperty.call(u,n)&&(t[n]=u[n]);s&&s(e);while(f.length)f.shift()();return l.push.apply(l,i||[]),r()}function r(){for(var t,e=0;e<l.length;e++){for(var r=l[e],n=!0,c=1;c<r.length;c++){var u=r[c];0!==o[u]&&(n=!1)}n&&(l.splice(e--,1),t=a(a.s=r[0]))}return t}var n={},o={test:0},l=[];function a(e){if(n[e])return n[e].exports;var r=n[e]={i:e,l:!1,exports:{}};return t[e].call(r.exports,r,r.exports,a),r.l=!0,r.exports}a.m=t,a.c=n,a.d=function(t,e,r){a.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:r})},a.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},a.t=function(t,e){if(1&e&&(t=a(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var r=Object.create(null);if(a.r(r),Object.defineProperty(r,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var n in t)a.d(r,n,function(e){return t[e]}.bind(null,n));return r},a.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return a.d(e,"a",e),e},a.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},a.p="/";var c=window["webpackJsonp"]=window["webpackJsonp"]||[],u=c.push.bind(c);c.push=e,c=c.slice();for(var i=0;i<c.length;i++)e(c[i]);var s=u;l.push([1,"chunk-vendors","chunk-common"]),r()})({1:function(t,e,r){t.exports=r("72fc")},"257c":function(t,e,r){},"6dbb":function(t,e,r){"use strict";var n=r("257c"),o=r.n(n);o.a},"72fc":function(t,e,r){"use strict";r.r(e);r("e260"),r("e6cf"),r("cca6"),r("a79d");var n=r("2b0e"),o=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{attrs:{id:"app"}},[r("router-view")],1)},l=[],a=r("2877"),c={},u=Object(a["a"])(c,o,l,!1,null,null,null),i=u.exports,s=r("8c4f"),p=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"root"},[r("el-row",{attrs:{gutter:"20"}},[r("el-col",{attrs:{span:12}},[r("el-input",{attrs:{placeholder:"输入手机号"},model:{value:t.mobile,callback:function(e){t.mobile=e},expression:"mobile"}})],1),r("el-col",{attrs:{span:12}},[r("el-button",{attrs:{type:"primary"},on:{click:t.call}},[t._v("拨打")])],1)],1),r("el-row",{attrs:{gutter:"20"}},[r("el-col",{attrs:{span:12}},[r("el-input",{attrs:{placeholder:"输入网址"},model:{value:t.url,callback:function(e){t.url=e},expression:"url"}})],1),r("el-col",{attrs:{span:12}},[r("el-button",{attrs:{type:"primary"},on:{click:t.openUrl}},[t._v("跳转")])],1)],1),r("el-row",{attrs:{gutter:"20"}},[r("el-col",{attrs:{span:12}},[r("p",{attrs:{align:"center"}},[t._v(t._s(t.barcodeShow))])]),r("el-col",{attrs:{span:12}},[r("el-button",{attrs:{type:"primary"},on:{click:t.barcode}},[t._v("扫码")])],1)],1),r("el-row",{attrs:{type:"flex",justify:"center"}},[r("el-col",{attrs:{span:1}},[r("el-button",{attrs:{type:"primary"},on:{click:t.back}},[t._v("返回")])],1)],1),r("el-row",{attrs:{type:"flex",justify:"center"}},[r("el-col",{attrs:{span:1}},[r("el-button",{attrs:{type:"primary"},on:{click:t.logout}},[t._v("注销")])],1)],1)],1)},f=[],d={name:"Test",data:function(){return{mobile:"",url:"https://www.hupun.com/",barcodeShow:"暂无条码"}},methods:{call:function(){window.location.href="tel://${this.mobile}"},openUrl:function(){console.log(this.url),window.js.handler.openUrlWithFilterUrl(this.url,"百度")},back:function(){window.js.handler.back()},logout:function(){window.js.handler.logout()},barcode:function(){window.js.handler.barcode("callback")},callback:function(t){this.barcodeShow=t}}},b=d,h=(r("6dbb"),Object(a["a"])(b,p,f,!1,null,"fb98a8c2",null)),w=h.exports;n["default"].use(s["a"]);var v="test",y=[{path:"/".concat(v,"/"),name:"Index",component:w}],m=new s["a"]({mode:"history",base:"/",routes:y}),g=m,j=r("2f62");n["default"].use(j["a"]);var _=new j["a"].Store({state:{},mutations:{},actions:{},modules:{}}),k=r("cf29");n["default"].config.productionTip=!1,Object(k["a"])();e["default"]=new n["default"]({router:g,store:_,render:function(t){return t(i)}}).$mount("#app")}});