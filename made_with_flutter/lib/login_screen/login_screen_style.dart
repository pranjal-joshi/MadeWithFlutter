
import 'package:flutter/material.dart';
import 'package:made_with_flutter/global_style.dart';

class ColorManager {
  Color _accentColor;
  bool _darkTheme;

  ColorManager(this._accentColor, this._darkTheme);

  LinearGradient getLinearGradient({Color fromColor, Color toColor, Alignment beginFrom, Alignment endAt}) {
    if(!_darkTheme) {
      return LinearGradient(
        begin: beginFrom,
        end: endAt,
        colors: [
          fromColor,
          toColor
        ]
      );
    }
    else {
      return LinearGradient(
        begin: beginFrom,
        end: endAt,
        colors: [
          fromColor.withOpacity(0.6),
          toColor.withOpacity(0.6)
        ]
      );
    }
  }

  ThemeData getMaterialTheme() {
    if(_darkTheme) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        canvasColor: Color.fromARGB(0xff, 30, 30, 30),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
        ),
        accentIconTheme: IconThemeData(
          color: _accentColor
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: getAppBarTextStyle()
          ),
        ),
      );
    }
    else {
      return ThemeData(
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.light,
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
        ),
        accentIconTheme: IconThemeData(
          color: Colors.black
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: getAppBarTextStyle()
          ),
        ),
      );
    }
  }

  Color getBackgroundColor() {
    if(_darkTheme) {
      return Color.fromRGBO(30, 30, 30, 1);
    }
    else {
      return Colors.white.withOpacity(0.95);
    }
  }

  TextStyle getAppBarTextStyle() {
    if(_darkTheme) {
      return TextStyle(
        fontFamily: defaultFont,
        fontWeight: FontWeight.w600,
        fontSize: fontSizeLarge,
        color: Colors.white,
        letterSpacing: 3,
      );
    }
    else {
      return TextStyle(
        fontFamily: defaultFont,
        fontWeight: FontWeight.w600,
        fontSize: fontSizeLarge,
        color: Colors.white,
        letterSpacing: 3
      );
    }
  }
}