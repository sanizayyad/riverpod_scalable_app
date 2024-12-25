import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_scalable_app/providers/isAuthenticated_provider.dart';
import 'package:riverpod_scalable_app/router/app_routes.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/notes/presentation/notes_screen.dart';


final goRouterProvider = Provider((ref) {
  return  GoRouter(
    initialLocation: AppRoute.notes.route,
    routes: [
      GoRoute(
        path: AppRoute.login.route,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path:  AppRoute.notes.route,
        name: AppRoute.notes.name,
        builder: (context, state) => const NotesScreen(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = ref.read(isAuthenticatedProvider);

      final isOnLoginPage = state.matchedLocation == AppRoute.login.route;

      if (!isAuthenticated && !isOnLoginPage) {
        // If the user is not authenticated and trying to access a protected route, redirect to login
        return AppRoute.login.route;
      }else if (isAuthenticated && isOnLoginPage) {
        // If the user is authenticated and trying to access the login page, redirect to notes
        return AppRoute.notes.route;
      }

      return null; // No redirection needed
    },
  );
});
