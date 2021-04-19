import 'package:flutter/material.dart';
import 'package:movies_browser/SignUp.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:movies_browser/favorites.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _resp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1B1222),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                // Center(
                //   child: Image.asset(
                //     "./assets/images/login.png",
                //     width: MediaQuery.of(context).size.width * 0.5,
                //   ),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 30),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Text(
                      "Please sign in to continue",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 350,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10.0,
                      child: TextField(
                        autocorrect: false,
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          labelText: "Email",
                          enabledBorder: new OutlineInputBorder(
                              // borderSide:
                              //     const BorderSide(color: Colors.white, width: 0.0),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 350,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10.0,
                      child: TextField(
                        obscureText: true,
                        autocorrect: false,
                        controller: passwordController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          labelText: "Password",
                          enabledBorder: new OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "_nbr",
                //   style: TextStyle(color: Colors.red),
                //   textAlign: TextAlign.left,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              animationDuration: Duration(seconds: 5)),
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          },
                          child: Text("Sign In"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("OR",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                          )),
                        ]),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            context
                                .read<AuthenticationService>()
                                .signInWithGoogle();
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: SignInButton(
                          Buttons.Facebook,
                          onPressed: () {
                            context
                                .read<AuthenticationService>()
                                .signInWithFacebook();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Don't have an account?",
                                style: TextStyle(color: Colors.white)),
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
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
