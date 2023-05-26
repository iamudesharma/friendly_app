// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:friendly_app/auth/repo/auth_repo.dart';

// final _authControllerProvider =
//     StateNotifierProvider<AuthController, bool>((ref) {
//   final authRepo = ref.watch(authRepoProvider.notifier);
//   return AuthController(authRepo);
// });


// class AuthController extends StateNotifier<bool> {


// static StateNotifierProvider<AuthController, bool>  get provider=> _authControllerProvider;

//   AuthController(
//     this.authRepo,
//   ) : super(false);

//   final AuthRepo authRepo;

//   void signIn({required String email, required String password}) async {
//     try {
//       state = true;
//       await authRepo.createUserByEmail(email, password);

//       Fluttertoast.showToast(
//           msg: "Login Successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);

//       state = false;
//     } catch (e) {
//       state = false;
//     }
//   }

//   void signUp({required String email, required String password ,required String name }) async {
//     try {
//       state = true;
//       await authRepo.createUser(email, password,name);

//       Fluttertoast.showToast(
//           msg: "Account Created Successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0);

//       state = false;
//     } catch (e) {
//       state = false;
//     }
//   }
// }
