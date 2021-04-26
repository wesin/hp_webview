import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hp_webview/src/hp_webview_const.dart';

import 'hp_webview_bloc.dart';
import 'hp_webview_event.dart';
import 'hp_webview_state.dart';
import 'model/index.dart';

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
        initialUrlRequest: this.viewInfo.url.startsWith(HPWebViewConst.filePath) ? null : URLRequest(url: Uri.parse(this.viewInfo.url)),
        onWebViewCreated: (controller) {
          if (this.viewInfo.url.startsWith(HPWebViewConst.filePath)) {
            _loadHtmlFromAssets(controller, this.viewInfo.url);
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

  void _loadHtmlFromAssets(InAppWebViewController controller, String path) async {
    String fileHtmlContents =
        await rootBundle.loadString(path.substring(HPWebViewConst.filePath.length));
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
