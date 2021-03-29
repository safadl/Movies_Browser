import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_browser/Authentication/SignIn.dart';
import 'package:movies_browser/authentication_service.dart';
import 'package:provider/provider.dart';
import 'getImages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Movies';

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.redAccent[700],
          primarySwatch: Colors.red,
        ),
        title: appTitle,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

// MyHomePage(title: appTitle)
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) return MyHomePage(title: 'Movies');
    return SignInPage();
  }
}
