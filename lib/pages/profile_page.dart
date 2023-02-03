import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/firebase_service.dart';

class ProfilePage extends StatefulWidget{

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05, vertical: _deviceHeight! * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileImage(),
        ],
      ),
    );
  }

  Widget _profileImage(){
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceHeight! * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(fit:BoxFit.cover,
            image: NetworkImage(_firebaseService!
            .currentUser!['image']))
      ),
    );
  }
}