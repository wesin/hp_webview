import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class HPWebViewState extends Equatable {
  /// notify change state without deep clone state
  final InAppWebViewController? webViewController;
  const HPWebViewState(this.webViewController);

  @override
  List<Object> get props => [this.webViewController ?? ""];
}

class HPWebViewInitState extends HPWebViewState {
  const HPWebViewInitState() : super(null);
}

class HPWebViewCreateState extends HPWebViewState {
  const HPWebViewCreateState(InAppWebViewController? controller)
      : super(controller);
}

class HPWebViewLoadStartState extends HPWebViewState {
  final Uri? uri;
  const HPWebViewLoadStartState(InAppWebViewController? controller, this.uri)
      : super(controller);

  @override
  List<Object> get props => [this.webViewController ?? "", this.uri ?? ""];
}

class HPWebViewProgressState extends HPWebViewState {
  final int progress;
  const HPWebViewProgressState(
      InAppWebViewController? controller, this.progress)
      : super(controller);

  @override
  List<Object> get props => [this.webViewController ?? "", this.progress];
}

class HPWebViewLoadStopState extends HPWebViewState {
  final Uri? uri;
  const HPWebViewLoadStopState(InAppWebViewController? controller, this.uri)
      : super(controller);
}

class HPWebViewLoadErrorState extends HPWebViewState {
  const HPWebViewLoadErrorState(
      InAppWebViewController? controller, this.uri, this.code, this.message)
      : super(controller);
  final Uri? uri;
  final int code;
  final String message;

  List<Object> get props =>
      [this.webViewController ?? "", this.uri ?? "", this.code, this.message];
}
