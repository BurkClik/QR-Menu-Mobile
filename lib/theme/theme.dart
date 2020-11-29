import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';

ThemeData theme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kPrimaryColor,
    //textButtonTheme: _buttonTextTheme(),
  );
}

/* TextButtonThemeData _buttonTextTheme() {
  return TextButtonThemeData(
    style: ButtonStyle(
      textStyle: 
    ),
  );
} */
