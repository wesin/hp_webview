import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hp_webview_progress_state.dart';

class WebViewProgressCubit extends Cubit<HPWebViewProgressState> {
  WebViewProgressCubit() : super(HPWebViewProgressState(0));

  void progressChanged(int progress) {
    if (progress != state.progress) {
      emit(HPWebViewProgressState(progress));
    }
  }
}
