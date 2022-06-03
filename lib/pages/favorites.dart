import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/pages/photo_full_info.dart';

import '../bloc/main_state.dart';
import '../elements/bloc/bloc_screen.dart';
import '../elements/photo/photo_card.dart';
import '../locator.dart';
import '../model/photo_model.dart';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  MainBloc? mainBloc;
  ScrollController scrollController = ScrollController();
  List<PhotoModel> photos = [];
  Map<String, dynamic> photosMap = {};
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
        bloc: mainBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              Scrollbar(
                  child: ListView.builder(
                      itemCount: photosMap.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int i) {
                        return PhotoCard(
                          photo: photosMap.values.elementAt(i),
                          openPhoto: _openPhoto,
                          like: _like,
                        );
                      })),
              Visibility(
                  visible: isLoading,
                  child: Center(
                      child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/loading.gif'),
                  )))
            ],
          ));
        });
  }

  _listener(BuildContext context, MainState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.action == "getFavorites") {
      photosMap = state.favorites!;
    }
  }

  void _openPhoto(PhotoModel photoModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullPhotoPage(
                  photo: photoModel,
                  photosMap: photosMap,
                  from: "favorites",
                )));
  }

  void _like(String id) {
    mainBloc!.setFavorite(id, photosMap, "favorites");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= locator.get<MainBloc>();
    mainBloc!.getFavorites();
  }
}
