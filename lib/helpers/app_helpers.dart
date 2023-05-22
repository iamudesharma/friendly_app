import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('YOUR_PROJECT_ID')
      .setSelfSigned(status: true);
});

final _accountProvider = Provider<Account>((ref) {
  return Account(ref.watch(_clientProvider));
});

final _databaseProvider = Provider<Databases>((ref) {
  return Databases(ref.watch(_clientProvider));
});

final _storageProvider = Provider<Storage>((ref) {
  return Storage(ref.watch(_clientProvider));
});

final _functionsProvider = Provider<Functions>((ref) {
  return Functions(ref.watch(_clientProvider));
});

final _localeProvider = Provider<Locale>((ref) {
  return Locale(ref.watch(_clientProvider));
});

final _teamsProvider = Provider<Teams>((ref) {
  return Teams(ref.watch(_clientProvider));
});

final class AppWriteClient {
  Provider<Account> get account => _accountProvider;
  Provider<Client> get client => _clientProvider;
  Provider<Databases> get database => _databaseProvider;
  Provider<Functions> get functions => _functionsProvider;
  Provider<Locale> get locale => _localeProvider;
  Provider<Storage> get storage => _storageProvider;
  Provider<Teams> get teams => _teamsProvider;
}
