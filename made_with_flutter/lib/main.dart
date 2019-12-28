import 'package:flutter/material.dart';
import 'package:made_with_flutter/helper.dart';
import 'package:made_with_flutter/login_screen/login_screen.dart';
import 'package:made_with_flutter/login_screen/login_screen_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FlutterHelper flutterHelper = FlutterHelper(context);
    ColorManager colorManager = ColorManager(Colors.purple, flutterHelper.isDarkModeActive());

    return MaterialApp(
      title: 'Made With Flutter',
      routes: {
        '\login_screen': (context) => LoginScreen(),
      },
      theme: colorManager.getMaterialTheme(),
      darkTheme: colorManager.getMaterialTheme(),
      home: LoginScreen(),
    );
  }
}