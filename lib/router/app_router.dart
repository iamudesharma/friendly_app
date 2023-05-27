import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/auth/pages/sign_in_page.dart';
import 'package:friendly_app/auth/pages/sign_up_page.dart';
import 'package:friendly_app/auth/repo/auth_repo.dart';
import 'package:friendly_app/home/home_page.dart';
import 'package:friendly_app/router/route_contants.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/dependency.dart';

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
              final user = ref.read(AuthRepo.provider).checkUserExist();

              if (user) {
                return null;
              }
              return AppRoute.signIn;
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
        GoRoute(
          path: "/phone",
          builder: (context, state) => PhoneInputScreen(actions: [
            SMSCodeRequestedAction((context, action, flowKey, phoneNumber) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SMSCodeInputScreen(
                    flowKey: flowKey,
                    actions: [
                      AuthStateChangeAction<SignedIn>((context, _state) async {
                        final _ctx = GoRouter.of(context);
                        var idToken = await _state.user!.getIdToken();

                        var serverResponse = await ref
                            .read(Dependency.client)
                            .modules
                            .auth
                            .firebase
                            .authenticate(idToken);

                        if (!serverResponse.success &&
                            serverResponse.userInfo != null) {
                          return;
                        }

                        await ref
                            .read(Dependency.sessionManager)
                            .registerSignedInUser(
                              serverResponse.userInfo!,
                              serverResponse.keyId!,
                              serverResponse.key!,
                            );

                        _ctx.replace(AppRoute.home);
                      }),
                      AuthStateChangeAction<UserCreated>(
                          (context, _state) async {
                        final _ctx = GoRouter.of(context);
                        var idToken =
                            await _state.credential.user!.getIdToken();

                        var serverResponse = await ref
                            .read(Dependency.client)
                            .modules
                            .auth
                            .firebase
                            .authenticate(idToken);

                        if (!serverResponse.success &&
                            serverResponse.userInfo != null) {
                          return;
                        }

                        await ref
                            .read(Dependency.sessionManager)
                            .registerSignedInUser(
                              serverResponse.userInfo!,
                              serverResponse.keyId!,
                              serverResponse.key!,
                            );

                        _ctx.replace(AppRoute.home);
                      }),
                    ],
                  ),
                ),
              );
            }),
          ]),
        )
      ],
    );
