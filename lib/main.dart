import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_app/screens/admin_home.dart';
import 'package:library_app/screens/home.dart';
import 'package:library_app/screens/login_screen.dart';
import 'package:library_app/screens/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library APP',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => Home(),
        '/admin': (context) => AdminHome(),
        '/userHome': (context) => UserHome()
      },
    );
  }
}
