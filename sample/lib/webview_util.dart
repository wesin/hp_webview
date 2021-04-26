import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_webview/hp_webview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


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
