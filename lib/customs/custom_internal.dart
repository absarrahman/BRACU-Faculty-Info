import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool isDark;

checkTheme(context) {
  isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
}

Color primaryColor = Color(0xff253494);

changeBrightness(context) {
  DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark);
}

Widget loading() {
  return Scaffold(
    body: Container(
      child: SpinKitRing(color: Colors.orange),
    ),
  );
}
