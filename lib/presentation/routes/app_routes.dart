import 'package:distribucion_app/data/models/menu_option.dart';
import 'package:distribucion_app/presentation/pages/add_client/add_client.dart';
import 'package:distribucion_app/presentation/pages/distribution/distribution_page.dart';
import 'package:distribucion_app/presentation/pages/home_page.dart';
import 'package:distribucion_app/presentation/widgets/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const initialState = "home";

  static final menuOptions = <MenuOption>[
    MenuOption(
      route: "/home",
      icon: Icons.list_alt,
      name: "Inicio",
      screen: const HomePage(),
    ),
    MenuOption(
      route: "/add-client",
      icon: Icons.list_alt,
      name: "Agregar Cliente",
      screen: const AddClient(),
    ),
    MenuOption(
      route: "/distribution",
      icon: Icons.list_alt,
      name: "Distribución",
      screen: const DistributionPage(),
    )
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (var option in menuOptions) {
      appRoutes.addAll({
        option.route: (BuildContext context) {
          return PageLayoutScreen(title: option.name, child: option.screen);
        }
      });
    }

    return appRoutes;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return PageLayoutScreen(title: 'Home', child: child);
          //   return Scaffold(
          //     appBar: AppBar(title: const Text('Main Layout')),
          //     body: child, // El contenido dinámico de las rutas hijas se muestra aquí
          //     bottomNavigationBar: BottomNavigationBar(
          //       items: const [
          //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          //         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          //       ],
          //       currentIndex: _getCurrentIndex(state),
          //       onTap: (index) {
          //         switch (index) {
          //           case 0:
          //             context.go('/home');
          //             break;
          //           case 1:
          //             context.go('/profile');
          //             break;
          //         }
          //       },
          //     ),
          //   );
          // },
        },
        routes: [
          GoRoute(
            path: '/home',
            // builder: (context, state) => const HomePage(),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            path: '/add-client',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const AddClient(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
          GoRoute(
            path: '/distribution',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const DistributionPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );

//   StatefulShellRoute(
//   branches: [
//     StatefulShellBranch(
//       routes: [
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const HomePage(),
//         ),
//       ],
//     ),
//     StatefulShellBranch(
//       routes: [
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) => const ProfilePage(),
//         ),
//       ],
//     ),
//   ],
//   builder: (context, state, child) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Stateful App')),
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: state.index, // Se mantiene el estado entre las rutas hijas
//         onTap: (index) {
//           // Lógica para cambiar de pestaña y mantener el estado
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   },
// ),
}
