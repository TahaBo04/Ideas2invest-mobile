import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color(0xFF1565C0),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Color(0xFF90CAF9),
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
);
