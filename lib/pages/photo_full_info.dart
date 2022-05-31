import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/model/photo_model.dart';

import '../DI/dependency-provider.dart';
import '../bloc/main_bloc.dart';
import '../bloc/main_state.dart';
import '../elements/bloc/bloc_screen.dart';

class FullPhotoPage extends StatefulWidget {
  PhotoModel photo;

  FullPhotoPage({required this.photo});
  @override
  State<StatefulWidget> createState() => _FullPhotoPage();
}

class _FullPhotoPage extends State<FullPhotoPage> {
  MainBloc? mainBloc;
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
                  )
                ],
              ),
            ),
          );
        });
  }

  _listener(BuildContext context, MainState state) {}
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
  }
}
