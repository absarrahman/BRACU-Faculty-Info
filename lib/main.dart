import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:faculty_info/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'customs/app_themes.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(BracuFacultyApp());
}

class BracuFacultyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultThemeId: AppThemes.Light,
      builder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: SplashScreen(),
      ),
      themeCollection: ThemeCollection(
        themes: {
          AppThemes.Light: ThemeData.light(),
          AppThemes.Dark: ThemeData.dark(),
        },
        fallbackTheme: ThemeData.light(),
      ),
    );
  }
}
