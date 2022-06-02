import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_tape/DI/dependency-provider.dart';
import 'package:photo_tape/pages/auth_page.dart';
import 'package:photo_tape/pages/main_page.dart';
import 'package:photo_tape/pages/photo_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(DependencyProvider(
    child: const MyApp(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Photo tape',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: AuthPage());
        home: MainPage());
  }
}
