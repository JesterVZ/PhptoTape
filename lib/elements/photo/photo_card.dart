import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoCard extends StatefulWidget {
  String url;
  PhotoCard({required this.url});
  @override
  State<StatefulWidget> createState() => _PhotoCard();
}

class _PhotoCard extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
        
      ]),
      child: Image(image: NetworkImage(widget.url)),
    );
  }
}
