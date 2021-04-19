import 'package:flutter/material.dart';
import 'package:movies_browser/Authentication/SignIn.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  String _nbr = "";
  final TextEditingController passwordController = TextEditingController();

  void checkPass(String pass) {
    if (pass.length < 6) {
      setState(() {
        _nbr = "Password must be at least 6 characters.";
      });
    } else {
      setState(() {
        _nbr = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Color(0xff1B1222)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Image.asset(
            "./assets/images/watch.png",
            width: MediaQuery.of(context).size.width * 0.4,
          ),
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
              borderRadius: BorderRadius.circular(10),
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
                  enabledBorder: new OutlineInputBorder(),
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
                onChanged: (passw) => checkPass(passwordController.text),
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
                  enabledBorder: new OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        Text(
          _nbr,
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.left,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Already have an account?",
                  style: TextStyle(color: Colors.white)),
            ),
            Container(
                padding: EdgeInsets.only(top: 20),
                child: TextButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    // context
                    //     .read<AuthenticationService>()
                    //     .signUp();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                ))
          ],
        )
      ]),
    ));
  }
}
