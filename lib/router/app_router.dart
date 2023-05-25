import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/auth/pages/sign_in_page.dart';
import 'package:friendly_app/auth/pages/sign_up_page.dart';
import 'package:friendly_app/auth/repo/auth_repo.dart';
import 'package:friendly_app/home/home_page.dart';
import 'package:friendly_app/router/route_contants.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter AppRouter(Ref ref) {
  return _router(ref);
}

GoRouter _router(Ref ref) => GoRouter(
      routes: <RouteBase>[
        GoRoute(
            path: AppRoute.home,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            redirect: (context, state) async {
              final user = await ref.read(authRepoProvider).value;

              if (user != null) {
                return null;
              } else {
                return AppRoute.signIn;
              }
            }),
        GoRoute(
          path: AppRoute.signIn,
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
        GoRoute(
          path: AppRoute.signUp,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUPPage();
          },
        ),
      ],
    );
