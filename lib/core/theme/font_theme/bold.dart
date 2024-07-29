import 'package:flutter/material.dart';

import 'font_theme.dart';

class BoldFontTheme extends FontTheme {
  BoldFontTheme({required super.theme});

  @override
  TextStyle get xs => super.xs.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get sm => super.sm.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get base => super.base.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get lg => super.lg.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get xl => super.xl.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get xxl => super.xxl.copyWith(fontWeight: FontWeight.bold);
  @override
  TextStyle get xxxl => super.xxxl.copyWith(fontWeight: FontWeight.bold);
}
