part of 'hp_webview_progress_cubit.dart';

class HPWebViewProgressState extends Equatable {
  final int progress;
  const HPWebViewProgressState(this.progress);

  @override
  List<Object> get props => [this.progress];
}
