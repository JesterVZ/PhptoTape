import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/photo_model.dart';

class PhotoCard extends StatefulWidget {
  PhotoModel photo;
  ValueChanged<PhotoModel> openPhoto;
  PhotoCard({required this.photo, required this.openPhoto});
  @override
  State<StatefulWidget> createState() => _PhotoCard();
}

class _PhotoCard extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.openPhoto.call(widget.photo);
        },
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
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
              child: Image(image: NetworkImage(widget.photo.url!)),
            )));
  }
}
