import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            onTap: () {},
            child: const Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: GestureDetector(
              onTap: () {},
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
}
