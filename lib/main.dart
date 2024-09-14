import 'package:distribucion_app/core/di/bloc_providers.dart';
import 'package:distribucion_app/core/share_preferences/preferences.dart';
import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:distribucion_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(MultiBlocProvider(
    providers: buildBlocProviders(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Distribution App',
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeCubit>().state.currentTheme,
    );
  }
}
