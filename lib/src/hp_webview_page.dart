import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'hp_webview_bloc.dart';
import 'hp_webview_filter.dart';
import 'model/webview_model.dart';
import 'hp_webview_screen.dart';

class HPWebViewPage extends StatefulWidget {
  static const String routeName = '/WebView';
  HPWebViewPage(this.viewInfo, {this.injectJSList, this.jsHandler, Key? key})
      : super(key: key);
  final WebViewModel viewInfo;
  final UnmodifiableListView<UserScript>? injectJSList;
  final Function(InAppWebViewController controller, BuildContext context)?
      jsHandler;

  @override
  _HPWebViewPageState createState() => _HPWebViewPageState();
}

class _HPWebViewPageState extends State<HPWebViewPage> {
  final _webViewBloc = HPWebViewBloc();
  WebViewModel? filterInfo;

  @override
  void initState() {
    if (widget.viewInfo.filterUrl?.isNotEmpty ?? false) {
      filterInfo = WebViewModel(widget.viewInfo.filterUrl!,
          title: widget.viewInfo.filterTitle);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewInfo.title ?? "万里牛"),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: Image.asset("assets/imgs/back.png"),
                onPressed: () => Navigator.of(context).maybePop());
          },
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              iconSize: 24,
              icon: Image.asset("assets/imgs/filter.png"),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            );
          })
        ],
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _webViewBloc),
          ],
          child: HPWebViewScreen(
            widget.viewInfo,
            injectJSList: widget.injectJSList,
            jsHandler: widget.jsHandler,
          )),
      endDrawer: filterInfo != null
          ? HPWebViewFilter(
              filterInfo!,
              injectJSList: widget.injectJSList,
              jsHandler: widget.jsHandler,
            )
          : null,
      //HPWebViewScreen(widget.url, _WebViewBloc),
    );
  }
}
