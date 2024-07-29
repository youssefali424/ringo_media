import 'package:flutter/material.dart';

extension PaddingModifier on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget paddingOnly(
          {double start = 0,
          double top = 0,
          double end = 0,
          double bottom = 0}) =>
      Padding(
        padding: EdgeInsetsDirectional.only(
            start: start, top: top, end: end, bottom: bottom),
        child: this,
      );
}
