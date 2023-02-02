import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_screen.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: 'home',
      routes: {
        'register':(context) => Register(),
        'login':(context) => Login(),
        'home':(context) => HomePage(),
      },
    );
  }
}