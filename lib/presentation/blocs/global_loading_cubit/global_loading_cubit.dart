import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'global_loading_state.dart';

class GlobalLoadingCubit extends Cubit<GlobalLoadingState> {
  GlobalLoadingCubit() : super(const GlobalLoadingState());

  void showLoading() async {
    emit(const GlobalLoadingState(loading: true));
  }

  void hideLoading() async {
    emit(const GlobalLoadingState(loading: false));
  }
}
