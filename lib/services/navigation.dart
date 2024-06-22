import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_24/widgets/activities_page.dart';
import 'package:project_24/widgets/home_page.dart';
import 'package:project_24/widgets/activity_info_dialog.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:provider/provider.dart';

final routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/categories',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: HomePage(selectedTab: HomeTab.categories)
      ),
      routes: <RouteBase>[
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ChangeNotifierProvider(
              create: (_) => ActivityViewModel(),
              child: child,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: ':categoryId/activities',
              builder: (context, state) {
                return ActivitiesPage(
                  categoryId: state.pathParameters['categoryId']!
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  path: ':activityId',
                  builder: (context, state) =>
                    ActivityInfoDialog(activityId: state.pathParameters['activityId']!),
                ),
              ],
            ),
            GoRoute(
              path: 'create',
              pageBuilder: (context, state) => const NoTransitionPage<void>(
                child: HomePage(selectedTab: HomeTab.categories)),
            )
          ]
        ),
      ],
    ),
  ],
  initialLocation: '/categories',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final currentPath = state.uri.path;
    if (currentPath == '/') {
      return '/categories';
    }
    // No redirection needed for other routes
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);

class NavigationService {
  late final GoRouter _router;

  NavigationService() {
    _router = routerConfig;
  }

  String _currentPath(BuildContext context) {
    return GoRouterState.of(context).uri.path;
  }

  void goHome({required HomeTab tab}) {
    _router.go('/${tab.name}');
  }

  void goActivitiesOnCategory({required String categoryId}) {
    _router.go('/categories/$categoryId/activities');
  }

  void goActivityInfoOnCategory(
      {required String categoryId, required String activityId}) {
    _router.go('/categories/$categoryId/activities/$activityId');
  }

  void backActivitiesOnInfo() {
    _router.pop();
  }

  void goCreateActivity() {
    _router.go('/categories/create');
  }
}