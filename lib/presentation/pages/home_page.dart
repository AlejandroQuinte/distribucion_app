import 'package:distribucion_app/core/theme/app_theme.dart';
import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:distribucion_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final dBloc = context.read<DistributionBloc>();
    final clientBloc = context.read<ClientBloc>();

    // final gloadingBloc = context.read<GlobalLoadingCubit>();
    // final eGlobalCubit = context.read<GlobalErrorCubit>();

    // LocalDatabaseRepository.db.getAllClients().then((value) {
    //   LocalDatabaseRepository.db.getAllDistributionByDate(DateTime.now()).then(
    //       (val) => getLocalDistribution(value, val, dBloc, DateTime.now()));
    //   clientBloc.add(GetClients(clients: value));
    // });

    if (clientBloc.state.clients.isEmpty) {
      clientBloc.add(GetClients(clients: const []));
    }

    return Center(
      child: Column(
        children: [
          ...AppRoutes.menuOptions.map((option) {
            if (option.route == '/home') {
              return Container();
            }
            return ElevatedButton(
              onPressed: () {
                context.push(option.route);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                option.name,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            );
          }),
        ],
      ),
    );
  }
}
