import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/bloc/main_bloc.dart';
import 'package:photo_tape/bloc/main_state.dart';

import '../DI/dependency-provider.dart';
import '../elements/bloc/bloc_screen.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  MainBloc? mainBloc;
  int page = 1;
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

              Visibility(
                      child: Center(
                          child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/loading.gif'),
                      )),
                      visible: isLoading)
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
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
    mainBloc!.getPhotos(page);
  }
}