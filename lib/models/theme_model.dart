import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  Color colorSchemeSeed = Colors.blue;
  Brightness brightness = Brightness.light;

  changeColorSchemeSeed(Color colorSchemeSeed) {
    this.colorSchemeSeed = colorSchemeSeed;
    notifyListeners();
  }

  changeBrightness() {
    brightness == Brightness.light
        ? brightness = Brightness.dark
        : brightness = Brightness.light;
    notifyListeners();
  }
}
