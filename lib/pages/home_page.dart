
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finstagram"),
        actions: [
          GestureDetector(
            onTap: (){},
            child: const Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: GestureDetector(
              onTap: (){},
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}