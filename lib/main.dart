import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResourceHUB',
      theme: appTheme,
      home: CourseListScreen(),
    );
  }
}
