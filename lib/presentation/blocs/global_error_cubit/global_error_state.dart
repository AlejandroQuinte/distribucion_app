part of 'global_error_cubit.dart';

@immutable
class GlobalErrorState {
  final String? message;
  final bool hasError;
  const GlobalErrorState({this.message, this.hasError = false});
}
