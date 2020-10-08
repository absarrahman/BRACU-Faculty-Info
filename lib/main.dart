import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:faculty_info/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BracuFacultyApp());
}

class BracuFacultyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness)=> ThemeData(
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: SplashScreen(),
      ),
    );
  }
}
