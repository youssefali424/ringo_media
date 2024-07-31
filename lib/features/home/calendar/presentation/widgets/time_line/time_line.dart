import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TimeLine extends StatefulWidget {
  final double itemHeight;
  final EdgeInsetsGeometry itemMargin;
  final Map<TimeOfDay, Widget> children;
  final bool showCurrentTime;
  const TimeLine({
    super.key,
    required this.itemHeight,
    this.showCurrentTime = true,
    this.itemMargin = const EdgeInsetsDirectional.only(bottom: 8, start: 16),
    required this.children,
  });

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  double get itemHeight => widget.itemHeight;
  EdgeInsetsGeometry get itemMargin => widget.itemMargin;
  double get height => itemHeight + itemMargin.vertical;
  double get timeWidth => 40;
  // TimeOfDay currentTime = TimeOfDay.now();
  final currentTime = ValueNotifier(TimeOfDay.now());
  Timer? timer;
  late ScrollController _controller;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      var now = TimeOfDay.now();
      if (widget.showCurrentTime && now != currentTime.value) {
        currentTime.value = now;
      }
    });
    var initialScrollOffset = calculatePOsition(currentTime.value);
    _controller = ScrollController(
        initialScrollOffset: max(initialScrollOffset - 100, 0));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  double calculatePOsition(TimeOfDay timeOfDay) {
    var percentage =
        ((timeOfDay.hour * TimeOfDay.minutesPerHour) + timeOfDay.minute) /
            TimeOfDay.minutesPerHour;
    return (percentage * height);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverStack(
            insetOnOverlap: false, // defaults to false
            children: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(List.generate(24, (i) {
                  var time = TimeOfDay(hour: i, minute: 0);
                  return SizedBox(
                    height: height,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: timeWidth,
                          child: Text(
                            time.format(context),
                            style: theme.medium.xs,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                  );
                })),
              ),
              ...widget.children.entries.map((entry) {
                var time = entry.key;
                var textDirection = Directionality.of(context);
                var resolvedMargin = itemMargin.resolve(textDirection);
                return SliverPositioned.directional(
                  top: calculatePOsition(time) + 8,
                  textDirection: textDirection,
                  end: resolvedMargin.right,
                  start: timeWidth + resolvedMargin.left,
                  child: Container(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: itemHeight,
                      child: entry.value,
                    ),
                  ),
                );
              }),
              if (widget.showCurrentTime)
                ValueListenableBuilder(
                    valueListenable: currentTime,
                    builder: (context, time, child) {
                      return SliverPositioned(
                        top: calculatePOsition(time),
                        right: 0,
                        left: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: timeWidth,
                              child: Text(
                                time.format(context),
                                style: theme.bold.xs,
                              ),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.primaryColor,
                                      )),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      );
                    }),
            ],
          ),
        ),
      ],
    );
  }
}
