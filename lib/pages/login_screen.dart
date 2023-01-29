import 'dart:ffi';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email, _password;

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
            children: [_titleWidget(), _loginForm(), _loginButton()],
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
      onPressed: () {},
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
            children: [
              _emailTextField(),
              _passwordTextField()
            ],
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

        result ? null : "Please Enter a Valid Email";
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
        validator: (value) => value!.length > 6
            ? null
            : "Password should be 6 characters minimum");
  }
}
