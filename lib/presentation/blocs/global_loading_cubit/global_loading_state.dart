part of 'global_loading_cubit.dart';

@immutable
class GlobalLoadingState {
  final bool loading;
  const GlobalLoadingState({this.loading = false});
}

class GlobalShowLoading extends GlobalLoadingState {
  const GlobalShowLoading() : super(loading: true);
}
