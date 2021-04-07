import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'hp_webview_bloc.dart';
import 'hp_webview_filter.dart';
import 'model/webview_model.dart';
import 'hp_webview_screen.dart';

class HPWebViewPage extends StatefulWidget {
  static const String routeName = '/WebView';
  HPWebViewPage({Key? key}) : super(key: key);

  @override
  _HPWebViewPageState createState() => _HPWebViewPageState();
}

class _HPWebViewPageState extends State<HPWebViewPage> {
  final _webViewBloc = HPWebViewBloc();
  WebViewModel? filterInfo;
  WebViewModel? viewInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Object? info = ModalRoute.of(context)?.settings.arguments;
    if (info == null) {
      return Center(child: Text("没有webview参数信息"));
    }
    viewInfo = info as WebViewModel;
    if (viewInfo?.filterUrl?.isNotEmpty ?? false) {
      filterInfo =
          WebViewModel(viewInfo!.filterUrl!, title: viewInfo!.filterTitle);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(viewInfo?.title ?? "万里牛"),
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
      body: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => _webViewBloc),
      ], child: HPWebViewScreen(viewInfo!)),
      endDrawer: filterInfo != null ? HPWebViewFilter(filterInfo!) : null,
      //HPWebViewScreen(widget.url, _WebViewBloc),
    );
  }
}
