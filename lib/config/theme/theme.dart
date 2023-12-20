import 'package:flutter/material.dart';

import '../../core/shared/constants.dart';

const kDefaultRed = Color(0XFFba4141);
const kDefaultReddishGrey = Color(0XFF664848);

// light theme
ThemeData theme() {
  return ThemeData(
    colorSchemeSeed: kDefaultReddishGrey,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: kDefaultFontFamily,
    appBarTheme: appBarTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kDefaultReddishGrey,
      foregroundColor: Colors.white,
    ),
  );
}

// dark theme
ThemeData darkTheme() {
  return ThemeData(
    colorSchemeSeed: kDefaultRed,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: kDefaultFontFamily,
    appBarTheme: appBarThemeDark(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kDefaultRed,
      foregroundColor: Colors.white,
    ),
  );
}

// light theme appbar
AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: kDefaultReddishGrey),
    actionsIconTheme: IconThemeData(color: kDefaultReddishGrey),
    titleTextStyle: TextStyle(
      color: kDefaultReddishGrey,
      fontSize: 18,
      fontFamily: kDefaultFontFamily,
      fontWeight: FontWeight.bold,
    ),
  );
}

// dark theme appbar
AppBarTheme appBarThemeDark() {
  return const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: kDefaultRed),
    actionsIconTheme: IconThemeData(color: kDefaultRed),
    titleTextStyle: TextStyle(
      color: kDefaultRed,
      fontSize: 18,
      fontFamily: kDefaultFontFamily,
      fontWeight: FontWeight.bold,
    ),
  );
}
