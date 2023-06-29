import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

// import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/router/app_router.dart';
import 'package:friendly_app_client/friendly_app_client.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'firebase_options.dart';
import 'helpers/dependency.dart';

late Client _client;

late SessionManager _sessionManager;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // The session manager keeps track of the signed-in state of the user. You
  // can query it to see if the user is currently signed in and get information
  // about the user.
  _sessionManager = SessionManager(
    caller: _client.modules.auth,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await _sessionManager.initialize();

  FirebaseUIAuth.configureProviders([EmailAuthProvider(), PhoneAuthProvider()]);
  // client
  //     .setEndpoint(AppConstants.projectEndpoint)
  //     .setProject(AppConstants.projectKey)
  //     .setSelfSigned(status: true); //
  runApp(ProviderScope(
      overrides: [Dependency.sessionManager.overrideWithValue(_sessionManager)],
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final route = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: route,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorSchemeSeed: const Color(0xff673AB7),
        primaryColorDark: const Color(0xff512DA8),
        primaryColorLight: const Color(0xffD1C4E9),
        // primaryColor: Color(0xff673AB7),
      ),
    );
  }
}
