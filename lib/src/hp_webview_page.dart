import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'hp_webview_bloc.dart';
import 'hp_webview_filter.dart';
import 'model/webview_model.dart';
import 'hp_webview_screen.dart';

class HPWebViewPage extends StatefulWidget {
  static const String routeName = '/HPWebView';
  HPWebViewPage({this.viewInfo, this.injectJSList, this.jsHandler, Key? key})
      : super(key: key);
  final WebViewModel? viewInfo;
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget>? rightActions(BuildContext context) {
    if (filterInfo == null) {
      return null;
    }
    return [
      Builder(builder: (context) {
        return IconButton(
          iconSize: 24,
          icon: Image.asset("assets/imgs/filter.png"),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        );
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    var viewInfo = widget.viewInfo;
    if (viewInfo == null) {
      var info = ModalRoute.of(context)?.settings.arguments;
      if (info == null || !(info is WebViewModel)) {
        return Container();
      }
      viewInfo = info;
    }
    if (viewInfo.filterUrl?.isNotEmpty ?? false) {
      filterInfo =
          WebViewModel(viewInfo.filterUrl!, title: viewInfo.filterTitle);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(viewInfo.title ?? "万里牛"),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: Image.asset("assets/imgs/back.png"),
                onPressed: () => Navigator.of(context).maybePop());
          },
        ),
        actions: rightActions(context),
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _webViewBloc),
          ],
          child: HPWebViewScreen(
            viewInfo,
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
