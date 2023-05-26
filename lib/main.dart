import 'package:flutter/material.dart';

// import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/constants/app_constants.dart';
import 'package:friendly_app/router/app_router.dart';

import 'helpers/dependency.dart';

// Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // client
  //     .setEndpoint(AppConstants.projectEndpoint)
  //     .setProject(AppConstants.projectKey)
  //     .setSelfSigned(status: true); //
  runApp(ProviderScope(overrides: [], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final route = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: route,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color(0xff2917CA),
      ),
    );
  }
}
