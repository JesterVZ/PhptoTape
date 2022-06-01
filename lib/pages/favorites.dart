import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/bloc/main_bloc.dart';

import '../DI/dependency-provider.dart';
import '../bloc/main_state.dart';
import '../elements/bloc/bloc_screen.dart';

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  MainBloc? mainBloc;
  @override
  Widget build(BuildContext context) {
    return BlocScreen<MainBloc, MainState>(
        bloc: mainBloc,
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Scaffold();
        });
  }

  _listener(BuildContext context, MainState state) {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc ??= DependencyProvider.of(context)!.mainBloc;
    mainBloc!.getFavorites();
  }
}
