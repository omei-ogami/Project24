import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_24/widgets/activities_page.dart';
import 'package:project_24/widgets/activity_item.dart';
import 'package:project_24/widgets/home_page.dart';
import 'package:project_24/widgets/activity_info_dialog.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'package:provider/provider.dart';
import 'package:project_24/widgets/chat_page.dart';
import 'package:project_24/view_models/me_vm.dart';
import 'package:project_24/view_models/all_messages_vm.dart';
import 'package:project_24/models/user.dart';
import 'package:project_24/widgets/auth_page.dart';
import 'package:project_24/services/authentication.dart';
import 'package:project_24/services/push_messaging.dart';
import 'package:project_24/widgets/create_activity.dart';

final routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) =>
          const NoTransitionPage<void>(child: AuthPage()),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final myId = Provider.of<AuthenticationService>(context, listen: false)
            .checkAndGetLoggedInUserId();
        if (myId == null) {
          debugPrint('Warning: ShellRoute should not be built without a user');
          return const SizedBox.shrink();
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MeViewModel>(
              create: (_) => MeViewModel(myId),
            ),
            //ChangeNotifierProvider<AllMessagesViewModel>(
            //  create: (_) => AllMessagesViewModel(id: currentActivity),
            //),
          ],
          child: child,
        );
      },
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
                      path: ':id',
                      builder: (context, state) =>
                        ActivityInfoDialog(categoryId: state.pathParameters['categoryId']!, id: state.pathParameters['id']!),
                      routes: <RouteBase>[
                        ShellRoute(
                          builder: (context, state, child) {
                            final myId = Provider.of<AuthenticationService>(context, listen: false)
                                .checkAndGetLoggedInUserId();
                            if (myId == null) {
                              debugPrint('Warning: ShellRoute should not be built without a user');
                              return const SizedBox.shrink();
                            }
                            //print(state.pathParameters['id']);
                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider<MeViewModel>(
                                  create: (_) => MeViewModel(myId),
                                ),
                                ChangeNotifierProvider<AllMessagesViewModel>(
                                  create: (_) => AllMessagesViewModel(id: state.pathParameters['id']!),
                                ),
                              ],
                              child: child,
                            );
                          },
                          routes: [
                            GoRoute(
                              path: 'chat',
                              pageBuilder: (context, state) {
                                final meViewModel = Provider.of<MeViewModel>(context, listen: true);

                                // Log out and ask user to log in again for the custom claim to take effect
                                if (meViewModel.isModeratorStatusChanged) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Provider.of<PushMessagingService>(context, listen: false)
                                        .unsubscribeFromAllTopics();
                                    Provider.of<AuthenticationService>(context, listen: false)
                                        .logOut();
                                  });
                                }

                                return NoTransitionPage<void>(
                                    child: StreamBuilder<User>(
                                  // Listen to the me state changes
                                  stream: meViewModel.meStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState != ConnectionState.active ||
                                        snapshot.data == null) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      debugPrint('Error loading user data: ${snapshot.error}');
                                      return const Center(
                                        child: Text('Error loading user data'),
                                      );
                                    }
                                    return ChatPage(id: state.pathParameters['id']!,);
                                  },
                                ));
                              },
                            ),
                          ],
                        ),
                      ]
                    ),
                  ],
                ),
                GoRoute(
                  path: 'create',
                  pageBuilder: (context, state) => const NoTransitionPage<void>(
                    child: CreateActivity(),
                  )
                )
              ]
            ),
          ],
        ),
      ],
    ),
  ],
  initialLocation: '/categories',
  debugLogDiagnostics: true, 
  redirect: (context, state) {
    final currentPath = state.uri.path;
    final isLoggedIn =
        Provider.of<AuthenticationService>(context, listen: false)
                .checkAndGetLoggedInUserId() != null;
    if (isLoggedIn && currentPath == '/auth') {
      return '/categories';
    }
    if (!isLoggedIn && currentPath != '/auth') {
      // Redirect to auth page if the user is not logged in
      return '/auth';
    }
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
      {required String categoryId, required String id}) {
    _router.go('/categories/$categoryId/activities/$id');
  }

  void backActivitiesOnInfo() {
    _router.pop();
  }

  void goActivityChatroom({required String categoryId, required String id}) {
    _router.go('/categories/$categoryId/activities/$id/chat');
  }

  void goCreateActivity() {
    _router.go('/categories/create');
  }

  void goActivitieOnCreatePage() {
    _router.pop();
  }

  void goNewPage() { // New method to navigate to the new page
    _router.go('/chat');
  }
}