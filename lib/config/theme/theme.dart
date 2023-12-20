import 'package:flutter/material.dart';

// light theme
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Newsreader',
    appBarTheme: appBarTheme(),
  );
}

// dark theme
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Newsreader',
    appBarTheme: appBarThemeDark(),
  );
}

// light theme appbar
AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}

// dark theme appbar
AppBarTheme appBarThemeDark() {
  return const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  );
}
