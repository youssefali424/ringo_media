import 'package:flutter/material.dart';

import 'font_theme.dart';

class MediumFontTheme extends FontTheme {
  MediumFontTheme({required super.theme});

  @override
  TextStyle get xs => super.xs.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get sm => super.sm.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get base => super.base.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get lg => super.lg.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get xl => super.xl.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get xxl => super.xxl.copyWith(fontWeight: FontWeight.w500);
  @override
  TextStyle get xxxl => super.xxxl.copyWith(fontWeight: FontWeight.w500);
}
