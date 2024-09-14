part of 'distribution_bloc.dart';

abstract class DistributionEvent {}

final class GetClientss extends DistributionEvent {
  final List<Client> clients;
  GetClientss({required this.clients});
}

final class IsLoading extends DistributionEvent {
  final bool isLoading;
  IsLoading(this.isLoading);
}

final class SetDate extends DistributionEvent {
  final DateTime date;
  SetDate(this.date);
}

final class GetDistributions extends DistributionEvent {
  final List<Distribution> distributions;
  GetDistributions({required this.distributions});
}

class UpdateDistribution extends DistributionEvent {
  final Distribution updatedDistribution;
  UpdateDistribution({required this.updatedDistribution});
}
