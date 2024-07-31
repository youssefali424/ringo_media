import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ringo_media/features/auth/login/presentation/screens/login_screen.dart';
import 'package:ringo_media/features/home/project/domain/entities/tabs.dart';
import 'package:ringo_media/features/home/project/presentation/widgets/base_home.dart';

GoRouter generateRoutes() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => BaseHome(
            body: child,
            selected: Tabs.values.firstWhere((tab) =>
                state.fullPath?.startsWith('/home/${tab.route}') ??
                state.matchedLocation.startsWith('/home/${tab.route}'))),
        routes: Tabs.values
            .map(
              (e) => GoRoute(
                name: e.name,
                path: '/home/${e.route}',
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                      child: e.screen,
                      transitionsBuilder:
                          (_, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child));
                },
              ),
            )
            .toList(),
      ),
    ],
  );
}
