part of 'distribution_bloc.dart';

@immutable
class DistributionState {
  final List<Distribution> distributions;
  final List<Client> clients;
  final List<TotalDistributionModel> totalDistributions;
  final bool isLoading;
  final DateTime date;

  const DistributionState({
    required this.distributions,
    required this.clients,
    required this.totalDistributions,
    required this.isLoading,
    required this.date,
  });

  DistributionState copyWith({
    List<Distribution>? distributions,
    List<Client>? clients,
    List<TotalDistributionModel>? totalDistributions,
    bool? isLoading,
    DateTime? date,
  }) {
    return DistributionState(
      distributions: distributions ?? this.distributions,
      clients: clients ?? this.clients,
      totalDistributions: totalDistributions ?? this.totalDistributions,
      isLoading: isLoading ?? this.isLoading,
      date: date ?? this.date,
    );
  }
}

class DistributionInitial extends DistributionState {
  DistributionInitial()
      : super(
          distributions: [],
          clients: [],
          totalDistributions: [],
          isLoading: false,
          date: DateTime.now(),
        );
}

class DataLoading extends DistributionState {
  const DataLoading({
    required super.distributions,
    required super.clients,
    required super.totalDistributions,
    required super.date,
    super.isLoading = true,
  });
}

class DataSuccess extends DistributionState {
  const DataSuccess({
    required super.distributions,
    required super.clients,
    required super.totalDistributions,
    required super.date,
    super.isLoading = false,
  });
}
