# hp_webview

基于Flutter_inappwebview实现Vue远程和本地打包加载的一个案例项目。

在webview上附加了头部进度条、中间加载动画的附加功能。

## Getting Started

此项目基于Flutter2.0实现。

思路来源于Flutter_inappwebview的案例。基于bloc机制做了些封装，防止webview rebuild。
也加入了web页面与Flutter交互的示例功能。

使用方式：

    ElevatedButton(
        onPressed: () => WebViewUtil.openWebView(
            WebViewModel("http://localhost:8765/test/", title: "VUE测试"),
            context),
        child: Text("测试"),
      ),