import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_screen.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        'feeds':(context) => FeedPage(),
        'profile':(context) => ProfilePage(),
      },
    );
  }
}