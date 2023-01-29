import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double? _deviceWidth, _deviceHeight;
  GlobalKey<FormState> _registerFormState = GlobalKey<FormState>();

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
              children: [_titleWidget(), _registerButton()],
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
    return MaterialButton(onPressed: (){},
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
    child: const Text("Register", style: TextStyle(color: Colors.white,),),
    );
  }
}
