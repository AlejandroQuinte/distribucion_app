import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'global_error_state.dart';

class GlobalErrorCubit extends Cubit<GlobalErrorState> {
  GlobalErrorCubit() : super(const GlobalErrorState());

  void showError(String message) {
    emit(GlobalErrorState(message: message, hasError: true));
  }

  void clearError() {
    emit(const GlobalErrorState());
  }
}
