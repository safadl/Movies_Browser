import 'package:flutter/material.dart';

import 'getImages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Popular Movies';

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent[700],
      ),
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}
