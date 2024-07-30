import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';

class MonthsChart extends StatefulWidget {
  final Map<int, double> monthsData;
  const MonthsChart({
    super.key,
    required this.monthsData,
  });

  @override
  State<MonthsChart> createState() => _MonthsChartState();
}

class _MonthsChartState extends State<MonthsChart> {
  int get currentMonth => DateTime.now().month;

  /// for testing different current months
  // int get currentMonth => 12;

  Map<int, double> get monthsData => widget.monthsData;
  @override
  Widget build(BuildContext context) {
    var monthsCount = 6;
    int firstMonth = currentMonth <= DateTime.monthsPerYear - 3
        ? max(currentMonth - 3, 1)
        : DateTime.monthsPerYear - monthsCount + 1;

    var visibleMonths =
        List.generate(monthsCount, (index) => firstMonth + index);
    var theme = Theme.of(context);
    return Column(children: [
      SizedBox(
        height: 188,
        child: SizedBox(
          height: double.infinity,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: visibleMonths
                  .mapIndexed((i, e) {
                    var isCurrentMonth = e == currentMonth;
                    var height =
                        lerpDouble(0, 138, (monthsData[e] ?? 0) / 100.0);
                    return [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isCurrentMonth)
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          monthsData[e]!.toStringAsFixed(0),
                                          style: theme.bold.base.copyWith(
                                              color:
                                                  theme.colorScheme.onPrimary),
                                        ),
                                        Text(
                                          "%",
                                          style: theme.medium.base.copyWith(
                                              color:
                                                  theme.colorScheme.onPrimary),
                                        ),
                                      ],
                                    ).paddingSymmetric(vertical: 4),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                  width: 16,
                                  child: CustomPaint(
                                    painter: TrianglePainter(
                                      strokeColor: theme.primaryColor,
                                      strokeWidth: 10,
                                      paintingStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                )
                              ],
                            ).paddingOnly(bottom: 14),
                          Container(
                            height: height,
                            decoration: BoxDecoration(
                                color:
                                    isCurrentMonth ? theme.primaryColor : null,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8)),
                                gradient: isCurrentMonth
                                    ? null
                                    : const LinearGradient(colors: [
                                        Color(0x1F191C2A),
                                        Color(0x0F191C2A),
                                      ])),
                          ).animate().scaleY(
                                alignment: Alignment.bottomCenter,
                                duration: 400.ms,
                                delay: 100.ms,
                              ),
                        ],
                      )),
                      if (i != visibleMonths.length - 1)
                        const SizedBox(width: 8),
                    ];
                  })
                  .expand((e) => e)
                  .toList()),
        ),
      ),
      Row(
        children: visibleMonths
            .map((month) => Expanded(
                  child: Center(
                    child: Text(DateFormat("MMM", context.locale.languageCode)
                        .format(DateTime.now().copyWith(month: month))),
                  ),
                ))
            .toList(),
      ).paddingOnly(top: 12),
    ]);
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x / 2, y)
      ..lineTo(x, 0)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
