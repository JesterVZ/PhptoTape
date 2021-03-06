import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_tape/model/photo_info.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../bloc/main_bloc.dart';
import '../bloc/main_state.dart';
import '../elements/bloc/bloc_screen.dart';
import '../locator.dart';

class FullPhotoPage extends StatefulWidget {
  PhotoModel photo;
  String from;
  Map<String, dynamic> photosMap;
  FullPhotoPage(
      {required this.photo, required this.photosMap, required this.from});
  @override
  State<StatefulWidget> createState() => _FullPhotoPage();
}

class _FullPhotoPage extends State<FullPhotoPage> {
  MainBloc? mainBloc;
  PhotoInfo? photoInfo;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
        bloc: mainBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: Image(image: NetworkImage(widget.photo.url!)),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          mainBloc!.setFavorite(
                              widget.photo.id!, widget.photosMap, widget.from);
                        }),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: SvgPicture.asset(
                            'assets/like.svg',
                            color: widget.photo.isFavorite == true
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(photoInfo != null
                              ? photoInfo!.owner!.username!
                              : "????????????????...")),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: SvgPicture.asset(
                              'assets/eye.svg',
                              color: Colors.grey,
                            ),
                          ),
                          Text(photoInfo != null
                              ? photoInfo!.views!
                              : "????????????????...")
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(photoInfo != null
                        ? photoInfo!.title!.content!
                        : "????????????????..."),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(photoInfo != null
                        ? photoInfo!.description!.content!
                        : "????????????????..."),
                  )
                ],
              ),
            ),
          );
        });
  }

  _listener(BuildContext context, MainState state) {
    if (state.loading == true) {
      return;
    }
    if (state.photoInfo != null) {
      setState(() {
        photoInfo = state.photoInfo;
      });
    }
    if (state.error != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text("????????????"),
                  content: Text(state.error.toString()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ]));
      return;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= locator.get<MainBloc>();
    mainBloc!.getInfo(widget.photo.id!, widget.photo.secret!);
  }
}
