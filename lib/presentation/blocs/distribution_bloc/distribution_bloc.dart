import 'package:bloc/bloc.dart';
import 'package:distribucion_app/data/models/distribution_model.dart';
import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:meta/meta.dart';

part 'distribution_event.dart';
part 'distribution_state.dart';

class DistributionBloc extends Bloc<DistributionEvent, DistributionState> {
  DistributionBloc() : super(DistributionInitial()) {
    on<IsLoading>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });

    on<SetDate>((event, emit) {
      emit(state.copyWith(date: event.date));
    });

    on<UpdateDistribution>((event, emit) {
      Distribution updatedDistribution = state.distributions.firstWhere(
        (d) =>
            d.id == event.updatedDistribution.id &&
            d.clientName == event.updatedDistribution.clientName,
      );

      final updatedDistributions = List.of(state.distributions);
      final index = updatedDistributions.indexOf(updatedDistribution);
      updatedDistributions[index] = event.updatedDistribution;
      emit(state.copyWith(distributions: updatedDistributions));
    });

    on<GetClientss>((event, emit) {
      emit(state.copyWith(
        clients: event.clients.isEmpty ? state.clients : event.clients,
      ));
    });

    on<GetDistributions>((event, emit) {
      emit(state.copyWith(
        distributions: event.distributions.isEmpty
            ? state.distributions
            : event.distributions,
      ));
    });
  }

  @override
  void onEvent(DistributionEvent event) {
    super.onEvent(event);
    print(event);
  }
}
