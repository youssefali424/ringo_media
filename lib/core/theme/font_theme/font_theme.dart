import 'package:flutter/material.dart';

abstract class FontTheme {
  final ThemeData theme;
  FontTheme({required this.theme});

  String? get fontFamily => theme.textTheme.bodyLarge?.fontFamily;

  TextStyle get xs => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
      );
  TextStyle get sm => TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
      );
  TextStyle get base => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
      );
  TextStyle get lg => TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
      );
  TextStyle get xl => TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
      );
  TextStyle get xxl => TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
      );
  TextStyle get xxxl => TextStyle(
        fontFamily: fontFamily,
        fontSize: 72,
      );
}
