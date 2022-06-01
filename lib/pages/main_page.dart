import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_tape/pages/photo_page.dart';

import '../elements/lk/bottom_nav_custom.dart';
import '../elements/lk/tab_item.dart';
import '../elements/lk/tab_nav.dart';
import 'lk.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  var _currentTab = TabItem.main;
  final _navKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };
  List<Widget> navigatorList = [];

  @override
  void initState() {
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.main],
      rootPage: PhotoPage(),
    ));
    navigatorList.add(TabNavigator(
      navigatorKey: _navKeys[TabItem.profile],
      rootPage: Lk(),
    ));
    super.initState();
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _navKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }
  Widget _buildOffstageNavigator(TabItem tabItem, Widget navigator) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: navigator,
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
              final isFirstRouteInCurrentTab =
                  !await _navKeys[_currentTab]!.currentState!.maybePop();

              if (isFirstRouteInCurrentTab) {
                //Не страница 'main'
                if (_currentTab != TabItem.main) {
                  _selectTab(TabItem.main);
                  return false;
                }
              }
              return isFirstRouteInCurrentTab;
            },
      child: Scaffold(
      body: IndexedStack(
        index: _currentTab.index,
        children: [
            _buildOffstageNavigator(TabItem.main, navigatorList[0]),
            _buildOffstageNavigator(TabItem.profile, navigatorList[1])
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    ));
  }
}