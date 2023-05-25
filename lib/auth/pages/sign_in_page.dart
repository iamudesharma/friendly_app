import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
                "Welcome back",
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
                child: Column(
                  children: [
                    TextFieldTapRegion(
                      child: TextFormField(
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
                      child: Text("Sign In"),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Forgot your Password?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1.3,
                          ),
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
                            fixedSize: Size(150, 40),
                          ),
                          icon: Image.network(
                            "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Text("Google"),
                          onPressed: () {},
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              fixedSize: Size(150, 40)),
                          icon: Image.network(
                            "https://cdn2.iconfinder.com/data/icons/social-media-2285/512/1_Facebook_colored_svg_copy-1024.png",
                            // "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png",
                            height: 30,
                            width: 30,
                          ),
                          label: Text("Facebook"),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
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
                    onPressed: () {},
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
