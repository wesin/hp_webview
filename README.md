# hp_webview

基于Flutter_inappwebview结合Flutter_bloc封装的打开webview的控件，
解决官方案例里setState后webview重新rebuild的问题。
增加了个头部进度条进度显示，加载中中间显示个加载动画。

sample中有加载本地Vue代码的范例。

## Getting Started

```
class JSHandlerConst {
  static const String close = "close";
  static const String openUrl = "openUrl";
  static const String logout = "logout";
  static const String getData = "getData";
  static const String setData = "setData";
  static const String back = "back";
  static const String openPage = "openPage";
}

class WebViewUtil {
  static void openWebView(WebViewModel viewInfo, BuildContext context) async {
    String injectJS = await rootBundle.loadString("assets/files/inject.js");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HPWebViewPage(viewInfo: viewInfo,
          injectJSList: UnmodifiableListView<UserScript>([
            UserScript(
                source: injectJS,
                injectionTime: UserScriptInjectionTime.AT_DOCUMENT_END),
          ]),
          jsHandler: _addJSHandler);
    }));
  }

  static void _addJSHandler(
      InAppWebViewController controller, BuildContext context) {
    controller.addJavaScriptHandler(
        handlerName: JSHandlerConst.close,
        callback: (_) {
          Navigator.of(context).pop();
        });
    controller.addJavaScriptHandler(
        handlerName: JSHandlerConst.openUrl,
        callback: (args) {
          var url = args[0]['url'];
          var title = args[0]['title'];
          var filterUrl = args[0]['filterurl'];
          var filterTitle = args[0]['filtertitle'];
          Navigator.of(context).pushNamed(HPWebViewPage.routeName,
              arguments: WebViewModel(url,
                  title: title,
                  filterUrl: filterUrl,
                  filterTitle: filterTitle));
          // bloc.add(JSHandlerOpenUrlEvent(args));
        });

    controller.addJavaScriptHandler(
        handlerName: JSHandlerConst.back,
        callback: (args) {
          Navigator.of(context).pop();
        });
  }
}

```

HPWebViewPage 就是需要打开的webview，WebViewModel里面传入需要打开的页面。
injectJS是需要注入到webview中的js方法，是webview与原生交互的桥梁。
jsHandler是接受网页传入的js方法。
