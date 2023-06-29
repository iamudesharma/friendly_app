import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/helpers/dependency.dart';
import 'package:friendly_app/router/route_contants.dart';
import 'package:go_router/go_router.dart';
import 'package:friendly_app/helpers/error.dart';
import 'package:serverpod_auth_firebase_flutter/serverpod_auth_firebase_flutter.dart';

class SignUPPage extends ConsumerStatefulWidget {
  const SignUPPage({super.key});

  @override
  ConsumerState<SignUPPage> createState() => _SignUPPageState();
}

class _SignUPPageState extends ConsumerState<SignUPPage>
    with RepositoryExceptionMixin {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Background color
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff2815CD),

                  Color(0xff564BD8),
                  Color(0xff564BD8)
                  // Colors.purpleAccent,
                ],
              ),
            ),
          ),
        ),

        Positioned(
            top: 205,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xff7B72FE).withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            )),
        Positioned(
          top: 220,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Enter your details below",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      letterSpacing: 1.3,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // TextFieldTapRegion(
                      //   child: TextFormField(
                      //     controller: _nameController,
                      //     enabled: true,
                      //     textInputAction: TextInputAction.go,
                      //     decoration: InputDecoration(
                      //       isDense: true,
                      //       labelText: "Name",
                      //       hintText: "Enter your name",
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldTapRegion(
                        child: TextFormField(
                          controller: _emailController,
                          enabled: true,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Email",
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldTapRegion(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          enabled: true,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Password",
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 35)),
                          child: const Text("Sign Up"),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final _ctx = GoRouter.of(context);
                            FocusScope.of(context).unfocus();

                            setState(() {
                              isLoading = true;
                            });
                            final users =
                                await exceptionHandler<UserCredential>(ref
                                        .read(Dependency.firebaseAuth)
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text))
                                    .catchError((e, st) {
                              setState(() {
                                isLoading = false;
                              });
                            });

                            var idToken = await users.user!.getIdToken();

                            var serverResponse = await exceptionHandler(ref
                                .read(Dependency.client)
                                .modules
                                .auth
                                .firebase
                                .authenticate(idToken));

                            if (!serverResponse.success &&
                                serverResponse.userInfo != null) {
                              // Failed to sign in.
                              // completer.complete(null);
                              return;
                            }

                            await exceptionHandler(ref
                                .read(Dependency.sessionManager)
                                .registerSignedInUser(
                                  serverResponse.userInfo!,
                                  serverResponse.keyId!,
                                  serverResponse.key!,
                                ));

                            setState(() {
                              isLoading = false;
                            });
                            _ctx.replace(AppRoute.home);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "OR",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              letterSpacing: 1.3,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                            ),
                            icon: Image.network(
                              "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png",
                              height: 30,
                              width: 30,
                            ),
                            label: const Text("Google"),
                            onPressed: () {},
                          ),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                fixedSize: const Size(150, 40)),
                            icon: Image.network(
                              "https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Facebook_colored_svg_copy-1024.png",
                              // "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png",
                              height: 30,
                              width: 30,
                            ),
                            label: const Text("Facebook"),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),

        Positioned.fill(
          child: Column(children: [
            const SizedBox(
              height: kTextTabBarHeight,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //     backgroundColor:
                    //         const Color(0xff7B72FE).withOpacity(0.8)),
                    child: const Text("Sign In"),
                    onPressed: () {
                      context.go(AppRoute.signIn);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Friendly App",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white, fontStyle: FontStyle.italic),
            ),
          ]),
        ),
      ],
    ));
  }
}
