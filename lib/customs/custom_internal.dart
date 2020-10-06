import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool isDark;

checkTheme(context) {
  isDark = Theme.of(context).brightness == Brightness.dark ? true : false;
}

changeBrightness(context) {
  DynamicTheme.of(context)
      .setBrightness(isDark ? Brightness.light : Brightness.dark);
}

Widget loading() {
  return Scaffold(
    body: Container(
      child: SpinKitRing(color: Colors.orange),
    ),
  );
}
