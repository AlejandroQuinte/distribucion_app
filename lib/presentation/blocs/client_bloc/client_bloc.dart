import 'package:bloc/bloc.dart';
import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/domain/usecases/clients/client_usecase.dart';
import 'package:distribucion_app/presentation/blocs/global_error_cubit/global_error_cubit.dart';
import 'package:distribucion_app/presentation/blocs/global_loading_cubit/global_loading_cubit.dart';
import 'package:meta/meta.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final GlobalLoadingCubit globalLoadingCubit;
  final GlobalErrorCubit globalErrorCubit;
  final ClientUseCase clientUseCase;

  ClientBloc(
    this.globalLoadingCubit,
    this.globalErrorCubit,
    this.clientUseCase,
  ) : super(ClientInitial()) {
    //
    on<GetClients>((event, emit) async {
      globalLoadingCubit.showLoading();

      final result = await clientUseCase.getAllClients();

      result.fold(
        (l) => globalErrorCubit.showError(l),
        (r) => emit(ClientState(clients: r)),
      );

      await simpleCloseLoading(globalLoadingCubit);
    });

    on<AddOneClient>((event, emit) async {
      globalLoadingCubit.showLoading();

      final result = await clientUseCase.addNewClientAndReturnUpdateList(
        event.client,
        state.clients,
      );

      result.fold(
        (l) => globalErrorCubit.showError(l),
        (r) => emit(ClientState(clients: r)),
      );

      await simpleCloseLoading(globalLoadingCubit);
    });

    on<DeleteOneClient>((event, emit) async {
      globalLoadingCubit.showLoading();

      final result = await clientUseCase.deleteClientAndReturnUpdatedList(
        event.idClient,
        state.clients,
      );

      result.fold(
        (l) => globalErrorCubit.showError(l),
        (r) => emit(ClientState(clients: r)),
      );

      await simpleCloseLoading(globalLoadingCubit);
    });
  }
}

Future<void> simpleCloseLoading(GlobalLoadingCubit globalLoadingCubit) async {
  await Future.delayed(const Duration(milliseconds: 500), () {
    globalLoadingCubit.hideLoading();
  });
}
