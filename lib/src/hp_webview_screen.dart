import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'hp_webview_bloc.dart';
import 'hp_webview_event.dart';
import 'hp_webview_state.dart';
import 'model/index.dart';

class JSHandlerConst {
  static const String close = "close";
  static const String openUrl = "openUrl";
  static const String logout = "logout";
  static const String getData = "getData";
  static const String setData = "setData";
  static const String back = "back";
  static const String openPage = "openPage";
}

class HPWebViewScreen extends StatelessWidget {
  const HPWebViewScreen(this.viewInfo, {this.injectJSList, this.jsHandler});
  final WebViewModel viewInfo;
  final UnmodifiableListView<UserScript>? injectJSList;
  final Function(InAppWebViewController controller, BuildContext context)?
      jsHandler;

  InAppWebView webviewInit(BuildContext context) {
    HPWebViewBloc vbloc = BlocProvider.of<HPWebViewBloc>(context);
    print("view init: ${this.viewInfo.url}");
    return InAppWebView(
        key: const Key("in_app_webview"),
        initialUrlRequest: URLRequest(url: Uri.parse(this.viewInfo.url)),
        onWebViewCreated: (controller) {
          if (jsHandler != null) {
            jsHandler!(controller, context);
          }
          if (viewInfo.url.contains("test.html")) {
            _loadHtmlFromAssets(controller);
          }
        },
        onLoadStart: (controller, uri) =>
            vbloc.add(HPWebViewLoadStartEvent(controller, uri)),
        onLoadError: (controller, uri, code, message) =>
            vbloc.add(HPWebViewLoadErrorEvent(controller, uri, code, message)),
        onLoadHttpError: (controller, uri, code, message) =>
            vbloc.add(HPWebViewLoadErrorEvent(controller, uri, code, message)),
        onLoadStop: (controller, uri) =>
            vbloc.add(WebViewLoadStopEvent(controller, uri)),
        onProgressChanged: (controller, progress) =>
            vbloc.add(WebViewProgressEvent(controller, progress)),
        initialUserScripts: this.injectJSList);
  }

  void _loadHtmlFromAssets(InAppWebViewController controller) async {
    String fileHtmlContents =
        await rootBundle.loadString("assets/files/test.html");
    controller.loadUrl(
        urlRequest: URLRequest(
            url: Uri.dataFromString(fileHtmlContents,
                mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        webviewInit(context),
        Positioned(
            top: 0,
            child: BlocBuilder<HPWebViewBloc, HPWebViewState>(
              builder: (context, state) {
                print(state);
                if (state is HPWebViewLoadStartState) {
                  return Container(
                      child: LinearProgressIndicator(value: 0), height: 2);
                }
                if (state is HPWebViewProgressState) {
                  return Container(
                      child:
                          LinearProgressIndicator(value: state.progress / 100),
                      height: 2);
                }
                return Container(height: 0, width: 0);
              },
            ),
            left: 0,
            right: 0),
        Center(
          child: BlocBuilder<HPWebViewBloc, HPWebViewState>(
            builder: (context, state) {
              if (state is HPWebViewLoadStartState ||
                  state is HPWebViewProgressState) {
                return CircularProgressIndicator();
              }
              return Container(height: 0, width: 0);
            },
          ),
        )
      ],
    );
  }
}