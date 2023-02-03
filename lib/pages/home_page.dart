import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  int _currentPageIndex = 0;
  final List<Widget> _demoPages = [
    FeedPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finstagram"),
        actions: [
          GestureDetector(
            onTap: _postImage,
            child: const Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: GestureDetector(
              onTap: () async{
                await _firebaseService!.logout();
                Navigator.popAndPushNamed(context, 'login');
              },
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _demoPages[_currentPageIndex],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
      BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile')
    ],
    currentIndex: _currentPageIndex,
    onTap: (index){
      setState(() {
        _currentPageIndex = index;
      });
      debugPrint(index.toString());
    },
    );
  }

  void _postImage() async{
    FilePickerResult? resultImage = await FilePicker.platform.pickFiles(type: FileType.image);
    File image = File(resultImage!.files.first.path!);
    await _firebaseService!.postImage(image);
  }
}
