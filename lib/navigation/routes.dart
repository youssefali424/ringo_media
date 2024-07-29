import 'package:go_router/go_router.dart';
import 'package:ringo_media/features/auth/login/login_screen.dart';

GoRouter generateRoutes() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
