import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              "Let's Get Started!",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: new InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Icon(Icons.person_outline)),
              contentPadding: EdgeInsets.all(8),
              labelText: 'Email',
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: new InputDecoration(
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.lock_outline)),
              contentPadding: EdgeInsets.all(8),
              labelText: 'Password',
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
          ),
        ),
      ]),
    ));
  }
}
