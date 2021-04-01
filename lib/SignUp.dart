import 'package:flutter/material.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.black87),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "./assets/images/popcorn.png",
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              "Create your Account",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 350,
            child: Material(
              elevation: 10.0,
              child: TextField(
                autocorrect: false,
                controller: emailController,
                style: TextStyle(height: 2.0),
                decoration: new InputDecoration(
                  // fillColor: Colors.orange,
                  // filled: true,
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person_outline, color: Colors.red)),
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Email',
                  enabledBorder: new OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
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
              elevation: 10.0,
              child: TextField(
                obscureText: true,
                autocorrect: false,
                controller: passwordController,
                style: TextStyle(height: 2.5),
                decoration: new InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lock_outline,
                        color: Colors.red,
                      )),
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'Password',
                  enabledBorder: new OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40.0),
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
              style: ButtonStyle(animationDuration: Duration(seconds: 5)),
              onPressed: () {
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              },
              child: Text("Register ")),
        ),
      ]),
    ));
  }
}
