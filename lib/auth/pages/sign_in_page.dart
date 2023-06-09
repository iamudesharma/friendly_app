import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendly_app/helpers/dependency.dart';
import 'package:friendly_app/helpers/error.dart';
import 'package:friendly_app/router/route_contants.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = ref.watch(authRepoProvider);
    return Scaffold(
      body: _SignInWidget(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController),
    );
  }
}

class _SignInWidget extends ConsumerWidget with RepositoryExceptionMixin {
  const _SignInWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;
  // _ctrl = ctrl;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  // final EmailAuthController _ctrl;

  @override
  Widget build(BuildContext context, ref) {
    bool isLoading = false;

    return Stack(
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
              SelectableText(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      
                      
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectableText(
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
                child: Builder(builder: (context) {
                  return Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          StatefulBuilder(builder: (context, setState) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 35)),
                                child: isLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : const Text("Sign In"),
                                onPressed: () async {
                                  final _ctx = GoRouter.of(context);
                                  FocusScope.of(context).unfocus();

                                  setState(() {
                                    isLoading = true;
                                  });
                                  final users =
                                      await exceptionHandler<UserCredential>(ref
                                              .read(Dependency.firebaseAuth)
                                              .signInWithEmailAndPassword(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text))
                                          .catchError((e, st) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });

                                  var idToken = await users.user!.getIdToken();

                                  var serverResponse = await exceptionHandler(
                                      ref
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
                                });
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Forgot your Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 1.3,
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "OR",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                  letterSpacing: 1.3,
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 40)),
                            icon: const Icon(Icons.phone),
                            label: const Text("Phone"),
                            onPressed: () {
                              context.push("/phone");
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
                    "Don't have account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    //     backgroundColor:
                    //         const Color(0xff7B72FE).withOpacity(0.8)),
                    child: const Text("Get Started"),
                    onPressed: () {
                      context.go(AppRoute.signUp);
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
            )
                .animate(adapter: ValueAdapter(0.5))
                // .shimmer(
                //   colors: [
                //     const Color(0xFFFFFF00),
                //     const Color(0xFF00FF00),
                //     const Color(0xFF00FFFF),
                //     const Color(0xFF0033FF),
                //     const Color(0xFFFF0000),
                //     const Color(0xFFFFFF00),
                //   ],
                // )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .saturate(delay: 0.5.seconds, duration: 2.seconds)
                .then() // set baseline time to previous effect's end time
                .tint(color: const Color(0xFF80DDFF))
                .then()
                .blurXY(end: 24)
                .fadeOut(),
          ]),
        ),
      ],
    );
  }
}
