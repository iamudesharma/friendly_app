// import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app_client/friendly_app_client.dart';

import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final _clientProvider = Provider<Client>((ref) {
  return Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
});

final _sessionManagerProvider = Provider<SessionManager>((ref){
  return SessionManager(caller: ref.read(_clientProvider).modules.auth);
});

// final _storageProvider = Provider<Storage>((ref) {
//   return Storage(ref.watch(_clientProvider));
// });

// final _functionsProvider = Provider<Functions>((ref) {
//   return Functions(ref.watch(_clientProvider));
// });

// final _localeProvider = Provider<Locale>((ref) {
//   return Locale(ref.watch(_clientProvider));
// });

// final _teamsProvider = Provider<Teams>((ref) {
//   return Teams(ref.watch(_clientProvider));
// });

final class Dependency {
  Provider<Client> get client => _clientProvider;
  Provider<SessionManager> get sessionManager => _sessionManagerProvider;
  // Provider<Functions> get functions => _functionsProvider;
  // Provider<Locale> get locale => _localeProvider;
  // Provider<Storage> get storage => _storageProvider;
  // Provider<Teams> get teams => _teamsProvider;
}
