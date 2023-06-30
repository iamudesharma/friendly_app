// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:friendly_app/helpers/dependency.dart';
import 'package:friendly_app/helpers/error.dart';

final _authRepoProvider = Provider((ref) {
  return AuthRepo(ref.read(Dependency.firebaseAuth), ref);
});

class AuthRepo with RepositoryExceptionMixin {
  final FirebaseAuth auth;
  final Ref ref;

  AuthRepo(
    this.auth,
    this.ref,
  );

  static Provider<AuthRepo> get provider => _authRepoProvider;

  bool checkUserExist() {
    return ref.read(Dependency.sessionManager).isSignedIn;
  }

  Future<bool> checkUserExistData() async {
    final user = await ref.read(Dependency.client).example.currentUser();

    if (user != null) {
      return true;
    }
    return false;
  }
}
