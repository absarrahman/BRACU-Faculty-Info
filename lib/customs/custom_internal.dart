import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:faculty_info/customs/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

late bool isDark;

checkTheme(context) {
  isDark = DynamicTheme.of(context)!.themeId == AppThemes.Dark ? true : false;
}

Color primaryColor = Color(0xff253494);

changeBrightness(context) {
  DynamicTheme.of(context)!.setTheme(DynamicTheme.of(context)!.themeId == AppThemes.Light ? AppThemes.Dark : AppThemes.Light);
}

Widget loading() {
  return Scaffold(
    body: Container(
      child: SpinKitRing(color: Colors.orange),
    ),
  );
}
