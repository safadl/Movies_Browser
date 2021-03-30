import 'package:flutter/material.dart';
import 'package:movies_browser/SignUp.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 3,
              //     blurRadius: 7,
              //     offset: Offset(10, 0), // changes position of shadow
              //   ),
              // ],
            ),
            child: Column(
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height / 2),

                TextField(
                  autocorrect: false,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextField(
                  obscureText: true,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              animationDuration: Duration(seconds: 5)),
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          },
                          child: Text("Sign In")),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signInWithGoogle();
                        },
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        onPressed: () {
                          context
                              .read<AuthenticationService>()
                              .signInWithFacebook();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Don't have an account?"),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 20),
                              child: TextButton(
                                child: Text('Sign Up'),
                                onPressed: () {
                                  // context
                                  //     .read<AuthenticationService>()
                                  //     .signUp();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
