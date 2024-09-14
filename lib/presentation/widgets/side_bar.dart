import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:distribucion_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color.fromARGB(35, 0, 0, 0),
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                        'https://www.namesnack.com/images/NameSnack-chicken-farm-business-names-6016x4016-2021083.jpeg?crop=21:16,smart&width=420&dpr=2'))),
            child: Text(
              'Distribución App',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
              ...AppRoutes.menuOptions.map((option) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    final currentLocation = GoRouterState.of(context).fullPath;
                    if (currentLocation != option.route) {
                      context.push(option.route);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(option.icon, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        option.name,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
          const Divider(),
          const ConfigSideBar(),
        ],
      ),
    );
  }
}

class ConfigSideBar extends StatelessWidget {
  const ConfigSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('Tema', style: textTheme.labelLarge),
        DropdownButton(
          value: context.watch<ThemeCubit>().state.themeType,
          style: textTheme.labelMedium,
          items: ThemeType.values
              .map(
                (e) => DropdownMenuItem(value: e, child: Text(e.displayName)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<ThemeCubit>().changeTheme(value);
            }
          },
        ),
      ],
    );
  }
}
