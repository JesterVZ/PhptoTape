import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/pages/photo_page.dart';

import '../../pages/lk.dart';


class TabNavigatorRoutes {
  static const String root = '/';
  static const String profile = '/testimony';
}

class TabNavigator extends StatelessWidget{
  TabNavigator({required this.navigatorKey, required this.rootPage});
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget rootPage;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context){
    return {
      TabNavigatorRoutes.root: (context) => rootPage,
      TabNavigatorRoutes.profile: (context) => Lk(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => routeBuilders[routeSettings.name!]!(context));
      },
    );
  }
}