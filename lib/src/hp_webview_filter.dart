import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'hp_webview_bloc.dart';
import 'model/webview_model.dart';

import 'hp_webview_screen.dart';

class HPWebViewFilter extends StatefulWidget {
  const HPWebViewFilter(this.viewInfo,
      {this.injectJSList, this.jsHandler, Key? key})
      : super(key: key);
  final WebViewModel viewInfo;
  final UnmodifiableListView<UserScript>? injectJSList;
  final Function(InAppWebViewController controller, BuildContext context)?
      jsHandler;
  @override
  _HPWebViewFilterState createState() => _HPWebViewFilterState();
}

class _HPWebViewFilterState extends State<HPWebViewFilter> {
  final _webViewBloc = HPWebViewBloc();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _webViewBloc),
      ],
      child: HPWebViewScreen(
        widget.viewInfo,
        injectJSList: widget.injectJSList,
        jsHandler: widget.jsHandler,
      ),
    ));
  }
}
