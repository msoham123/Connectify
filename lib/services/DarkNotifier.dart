import 'package:connectify/main.dart';
import 'package:flutter/material.dart';

class DarkNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
    MyApp.box.put("darkMode", isDarkMode);
  }

}