import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum TabItem{
  main,
  profile
}

const Map<TabItem, String> tabName = {
  TabItem.main: 'Фото',
  TabItem.profile: 'Профиль'
};

const Map<TabItem, IconData> TabIcons = {
  TabItem.main: Icons.photo,
  TabItem.profile: Icons.settings
};