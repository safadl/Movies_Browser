import 'package:flutter/material.dart';

import 'getImages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Movies';

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent[700],
        primarySwatch: Colors.red,
      ),
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}
