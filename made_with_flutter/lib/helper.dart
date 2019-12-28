
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterHelper {

  BuildContext _context;

  FlutterHelper(this._context);

  bool _getDarkThemeState() {
    var brightness = MediaQuery.of(_context).platformBrightness;
    if(brightness == Brightness.dark) {
      return true;
    }
    else {
      return false;
    }
  }

  bool _getDarkModeState() {
    final ThemeData theme = Theme.of(_context);
    if(theme.brightness == ThemeData.dark().brightness) {
      return true;
    }
    else {
      return false;
    }
  }

  bool isDarkModeActive() {
    if(_getDarkModeState() || _getDarkThemeState()) {
      return true;
    }
    return false;
  }
}