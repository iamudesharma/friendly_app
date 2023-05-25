import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:friendly_app/helpers/dependency.dart';
import 'package:friendly_app/helpers/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repo.g.dart';

@Riverpod(keepAlive: true)
class AuthRepo extends _$AuthRepo with RepositoryExceptionMixin {
  @override
  FutureOr<User?> build() async {
    final user = await getUser();

    return user;
  }

  FutureOr<User?> createUser(String email, String password, String name) async {
    final user = await exceptionHandler<User>(
      ref.read(Dependency().account).create(
          userId: ID.unique(), email: email, password: password, name: name),
    );

    return user;
  }

  FutureOr<User?> createUserByEmail(String email, String password) async {
    state = AsyncValue.loading();
    final user = await exceptionHandler<User?>(ref
        .read(Dependency().account)
        .createEmailSession(email: email, password: password));

    return user;
  }

  FutureOr<User?> createPhoneUser(String phone) async {
    return exceptionHandler<User?>(ref
        .read(Dependency().account)
        .createPhoneSession(userId: ID.unique(), phone: phone));
  }

  FutureOr<User?> phoneVerify(String secret) async {
    return exceptionHandler<User?>(ref
        .read(Dependency().account)
        .updatePhoneSession(userId: ID.unique(), secret: secret));
  }

  FutureOr<User?> getUser() async {
    try {
      final user = ref.read(Dependency().account).get();

      return user;
    } on AppwriteException catch (_) {
      return null;
    } on Exception catch (_) {
      return null;
    }
    // return ;
  }
}
