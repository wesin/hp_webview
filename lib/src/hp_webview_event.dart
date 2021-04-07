import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meta/meta.dart';

import 'hp_webview_bloc.dart';
import 'hp_webview_state.dart';

@immutable
abstract class HPWebViewEvent {
  const HPWebViewEvent(
      {this.controller,
      this.uri,
      this.progress = 0,
      this.code = 0,
      this.message = ''});
  final InAppWebViewController? controller;
  final Uri? uri;
  final int progress;
  final int code;
  final String message;

  Stream<HPWebViewState> applyAsync(
      {HPWebViewState currentState, HPWebViewBloc bloc});
}

class WebViewCreateEvent extends HPWebViewEvent {
  const WebViewCreateEvent(InAppWebViewController controller)
      : super(controller: controller);
  @override
  Stream<HPWebViewState> applyAsync(
      {HPWebViewState? currentState, HPWebViewBloc? bloc}) async* {
    yield HPWebViewLoadStartState(this.controller, uri);
  }
}

class HPWebViewLoadStartEvent extends HPWebViewEvent {
  const HPWebViewLoadStartEvent(InAppWebViewController controller, Uri? uri)
      : super(controller: controller, uri: uri);
  @override
  Stream<HPWebViewState> applyAsync(
      {HPWebViewState? currentState, HPWebViewBloc? bloc}) async* {
    yield HPWebViewLoadStartState(this.controller, uri);
  }
}

class WebViewProgressEvent extends HPWebViewEvent {
  const WebViewProgressEvent(InAppWebViewController controller, this.progress)
      : super(controller: controller, progress: progress);
  final int progress;
  @override
  Stream<HPWebViewState> applyAsync(
      {HPWebViewState? currentState, HPWebViewBloc? bloc}) async* {
    yield HPWebViewProgressState(this.controller, progress);
  }
}

class WebViewLoadStopEvent extends HPWebViewEvent {
  const WebViewLoadStopEvent(InAppWebViewController controller, Uri? uri)
      : super(controller: controller, uri: uri);
  @override
  Stream<HPWebViewState> applyAsync(
      {HPWebViewState? currentState, HPWebViewBloc? bloc}) async* {
    yield HPWebViewLoadStopState(this.controller, uri);
  }
}

class HPWebViewLoadErrorEvent extends HPWebViewEvent {
  const HPWebViewLoadErrorEvent(
      InAppWebViewController controller, Uri? uri, int code, String message)
      : super(controller: controller, uri: uri, code: code, message: message);
  @override
  Stream<HPWebViewState> applyAsync(
      {HPWebViewState? currentState, HPWebViewBloc? bloc}) async* {
    yield HPWebViewLoadErrorState(
        this.controller, uri, this.code, this.message);
  }
}
