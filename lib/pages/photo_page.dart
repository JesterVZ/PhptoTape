import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/bloc/main_state.dart';
import 'package:photo_tape/elements/photo/photo_card.dart';
import 'package:photo_tape/model/photo_model.dart';
import 'package:photo_tape/pages/photo_full_info.dart';

import '../DI/dependency-provider.dart';
import '../elements/bloc/bloc_screen.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoPage();
}

class _PhotoPage extends State<PhotoPage> {
  MainBloc? mainBloc;
  int page = 1;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<PhotoModel> photos = [];
  Map<String, dynamic> photosMap = {};
  bool isLoading = false;

  @override
  void initState() {
    scrollController.addListener(_pagination);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
      bloc: mainBloc,
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              body: Column(
            children: [
              Container(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 55,
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            hintText: "Введите тэги (например: 'cat dog')",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                    Container(
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {
                            mainBloc!.getPhotos(page, searchController.text);
                          },
                          child: const Text("Поиск")),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Stack(
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
              ))
            ],
          )),
        );
      },
    );
  }

  void _pagination(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      setState(() {
        page++;
        mainBloc!.getPhotos(page, searchController.text);
      });
    }
  }

  void _openPhoto(PhotoModel photoModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullPhotoPage(
                  photo: photoModel,
                  photosMap: photosMap,
                  from: "photo",
                )));
  }

  void _like(String id) {
    mainBloc!.setFavorite(id, photosMap, "photo");
  }

  _listener(BuildContext context, MainState state) {
    isLoading = state.loading!;
    if (state.loading == true) {
      return;
    }
    if (state.error != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text("Ошибка"),
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
    if (state.photos != null) {
      if (state.action == "search" && page == 1) {
        photosMap = state.photos!;
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn);
      }
      if(state.action == "search" && page > 1){
        photosMap.addEntries(state.photos!.entries);
      }
      if (state.action == "setFavorite") {
        setState(() {
          photosMap = state.photos!;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
  }
}
