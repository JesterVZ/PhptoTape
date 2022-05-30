import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/bloc/main_state.dart';
import 'package:photo_tape/elements/photo/photo_card.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../DI/dependency-provider.dart';
import '../elements/bloc/bloc_screen.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  MainBloc? mainBloc;
  int page = 1;
  ScrollController scrollController = ScrollController();
  List<PhotoModel> photos = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
      bloc: mainBloc, 
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
          body:  Stack(
            children: [
              Scrollbar(
                child: ListView.builder(itemCount: photos.length, controller: scrollController, reverse: true, itemBuilder: (BuildContext context, int i){
                  return PhotoCard(url: photos[i].url!);
                })
              ),
              Visibility(
                      visible: isLoading,
                      child: Center(
                          child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/loading.gif'),
                      )))
            ],
          )
        );
      },
    );
  }
  _listener(BuildContext context, MainState state) {
    isLoading = state.loading!;
    if(state.loading == true){
      return;
    }
    if(state.photos != null){
      photos = state.photos!;
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
    mainBloc!.getPhotos(page);
  }
}