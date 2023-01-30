import 'dart:ffi';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double? _deviceWidth, _deviceHeight;
  String? _name, _email, _password;
  final GlobalKey<FormState> _registerFormState = GlobalKey<FormState>();

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
              children: [_titleWidget(), _registerForm(), _registerButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "Register",
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black45),
    );
  }

  Widget _registerButton(){
    return MaterialButton(onPressed: (){
      _registerUser;
    },
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
    child: const Text("Register", style: TextStyle(color: Colors.white,),),
    );
  }

  Widget _registerForm(){
    return Container(
      height: _deviceHeight! * 0.2,
      child: Form(
        key: _registerFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _nameTextField(),
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
        validator: (value) => value!.length > 6
            ? null
            : "Password should be 6 characters minimum");
  }

  Widget _nameTextField(){
    return TextFormField(
      decoration: const InputDecoration(hintText: "Username"),
      onSaved: (value){
        setState(() {
          _name = value;
        });
      },
      validator: (value)=> value!.isEmpty ? null : "Name can not be blank",
    );
  }

  void _registerUser(){
    if(_registerFormState.currentState!.validate()){
      _registerFormState.currentState!.save();
    }
  }
}
