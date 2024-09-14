import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:distribucion_app/presentation/blocs/distribution_bloc/distribution_bloc.dart';
import 'package:uuid/uuid.dart';

List<Distribution> getLocalDistribution(
  List<Client> clients,
  List<Distribution> distributions,
  DistributionBloc dBloc,
  DateTime? date,
) {
  if (distributions.isEmpty) {
    final id = const Uuid().v4();
    final saveDate = date ?? dBloc.state.date;
    distributions = clients
        .map((client) => Distribution(
              id: id,
              date: saveDate,
              clientName: client.name,
              clientCode: client.code,
              idClient: client.idClient,
              cartons: 0,
              discounts: 0,
              typePay: 'Ticket',
              observations: '',
            ))
        .toList();
    dBloc.add(GetDistributions(distributions: distributions));
  } else {
    dBloc.add(GetDistributions(distributions: distributions));
  }

  return distributions;
}
