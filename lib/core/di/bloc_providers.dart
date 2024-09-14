import 'package:distribucion_app/core/share_preferences/preferences.dart';
import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/domain/usecases/clients/client_usecase.dart';
import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> buildBlocProviders() {
  return [
    BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(Preferences.themeType)),
    BlocProvider<DistributionBloc>(create: (_) => DistributionBloc()),
    BlocProvider<GlobalErrorCubit>(create: (_) => GlobalErrorCubit()),
    BlocProvider<GlobalLoadingCubit>(create: (_) => GlobalLoadingCubit()),
    BlocProvider<ClientBloc>(
      create: (context) => ClientBloc(
        context.read<GlobalLoadingCubit>(),
        context.read<GlobalErrorCubit>(),
        ClientUseCase(LocalDatabaseRepository()),
      ),
    ),
  ];
}
