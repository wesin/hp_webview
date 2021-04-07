import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'hp_webview_event.dart';
import 'hp_webview_state.dart';

class HPWebViewBloc extends Bloc<HPWebViewEvent, HPWebViewState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  HPWebViewBloc() : super(HPWebViewInitState());
  // static final HPWebViewBloc _WebViewBlocSingleton =
  //     HPWebViewBloc._internal();
  // factory HPWebViewBloc() {
  //   return _WebViewBlocSingleton;
  // }
  // HPWebViewBloc._internal() : super(HPWebViewInitState());

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  Stream<HPWebViewState> mapEventToState(
    HPWebViewEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'HPWebViewBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
