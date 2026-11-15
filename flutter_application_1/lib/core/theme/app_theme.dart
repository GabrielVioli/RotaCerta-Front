import 'package:flutter/material.dart';

class AppTheme {
  static const double espacamento = 16;

  static final ThemeData tema = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
