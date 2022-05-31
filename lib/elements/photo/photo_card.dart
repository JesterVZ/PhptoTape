import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
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
                ),
                Positioned(
                    bottom: 5,
                    left: 5,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset(
                        'assets/like.svg',
                        color: Colors.grey,
                      ),
                    ))
              ],
            )));
  }
}
