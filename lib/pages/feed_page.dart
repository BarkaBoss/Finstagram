import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget{

  @override
  State createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{

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
      height: _deviceHeight,
      width: _deviceWidth,
      child: _postsListView(),
    );
  }
  Widget _postsListView(){
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getLatestPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          print("feed>> $snapshot.data!");
          return ListView();
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}