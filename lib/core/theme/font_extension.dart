import 'package:flutter/material.dart';

import 'font_theme/bold.dart';
import 'font_theme/font_theme.dart';
import 'font_theme/medium.dart';
import 'font_theme/regular.dart';
import 'font_theme/semi_bold.dart';

extension FontExt on ThemeData {
  // final FontTheme _regular;
  static final _regular = Expando<RegularFontTheme>();
  static final _medium = Expando<MediumFontTheme>();
  static final _semiBold = Expando<SemiBoldFontTheme>();
  static final _bold = Expando<BoldFontTheme>();

  FontTheme get regular {
    return _regular[this] ??= RegularFontTheme(theme: this);
  }

  FontTheme get medium {
    return _medium[this] ??= MediumFontTheme(theme: this);
  }

  FontTheme get semiBold {
    return _semiBold[this] ??= SemiBoldFontTheme(theme: this);
  }

  FontTheme get bold {
    return _bold[this] ??= BoldFontTheme(theme: this);
  }
}

extension FontExt2 on TextStyle {
  TextStyle get secondary => copyWith(color: const Color(0xff96A0B5));
}
