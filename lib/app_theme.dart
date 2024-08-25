import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: const Color(0xFF2196F3),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: const Color(0xFF1976D2),
  ).copyWith(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1976D2),
  ),
);
