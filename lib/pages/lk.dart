import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lk extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Lk();
}

class _Lk extends State<Lk>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Text("Profile")),
    );
  }
}