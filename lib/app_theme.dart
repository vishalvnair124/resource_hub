import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Color(0xFF2196F3),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Color(0xFF1976D2),
  ).copyWith(
    background: Color(0xFFBBDEFB),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1976D2),
  ),
);
