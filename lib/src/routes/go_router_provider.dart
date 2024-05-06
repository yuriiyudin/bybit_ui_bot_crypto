import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terminal_octopus/src/features/dashboard/history/view/history_screen.dart';
import 'package:terminal_octopus/src/features/dashboard/main_screen.dart';
import 'package:terminal_octopus/src/features/dashboard/signals/signals_screen.dart';
import 'package:terminal_octopus/src/routes/named_route.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
 
    routes: [
    GoRoute(
      path: '/',
      name: MyAppRouteConstants.homeRouteName,
      builder: ((context, state) => HomeScreen(
            key: state.pageKey,
          )),
    ),
    GoRoute(
      path: '/signals',
      name: MyAppRouteConstants.signals,
      builder: ((context, state) => SignalsScreen(
            key: state.pageKey,
          )),
    ),
      GoRoute(
      path: '/history',
      name: MyAppRouteConstants.history,
      builder: ((context, state) => HistoryScreen(
    
            key: state.pageKey,
          )),
    ),

  ]);
});
