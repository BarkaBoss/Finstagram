import 'dart:ffi';

import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Login extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email, _password;


  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleWidget(),
              _loginForm(),
              _loginButton(),
              _registerPageLink()
            ],
          ),
        ),
      )),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "Finstagram",
      style: TextStyle(
          color: Colors.black45, fontWeight: FontWeight.w600, fontSize: 25),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.2,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_emailTextField(), _passwordTextField()],
          )),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email Address..."),
      onSaved: (value) {
        setState(() {
          _email = value;
        });
      },
      validator: (value) {
        bool result = value!.contains(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"));

        return result ? null : "Please enter a valid email";
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
        decoration: const InputDecoration(hintText: "Password"),
        obscureText: true,
        obscuringCharacter: "*",
        onSaved: (value) {
          setState(() {
            _password = value;
          });
        },
        validator: (value) => value!.length >= 6
            ? null
            : "Password should be 6 characters minimum");
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have and account?",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  void _loginUser() async{
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool result = await _firebaseService!.loginUser(email: _email!, password: _password!);
      print(result);
      if(result){
        Navigator.pushNamed(context, "home");
      }
    }
  }
}
