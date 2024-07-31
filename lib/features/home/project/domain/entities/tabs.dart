import 'package:flutter/material.dart';
import 'package:ringo_media/features/home/project/presentation/screens/account.dart';
import 'package:ringo_media/features/home/calendar/presentation/screens/calendar.dart';
import 'package:ringo_media/features/home/project/presentation/screens/grid.dart';
import 'package:ringo_media/features/home/project/presentation/screens/project.dart';

import '../../../../../generated/locale_keys.g.dart';

enum Tabs {
  grid,
  project,
  calendar,
  user;

  String get route => name;

  Widget get screen => switch (this) {
        Tabs.grid => const GridScreen(),
        Tabs.project => const ProjectScreen(),
        Tabs.calendar => const CalendarScreen(),
        Tabs.user => const AccountScreen(),
      };
  Widget icon(
      {required Color color, required double size, required bool selected}) {
    return switch (this) {
      Tabs.grid => Icon(
          Icons.grid_view,
          color: color,
          size: size,
          fill: selected ? 1 : 0,
        ),
      Tabs.project => Image.asset(
          selected
              ? "assets/images/project_selected.png"
              : "assets/images/project.png",
          width: size,
          height: size,
          color: color,
        ),
      Tabs.calendar => Image.asset(
          selected
              ? "assets/images/calendar_selected.png"
              : "assets/images/calendar.png",
          width: size,
          height: size,
          color: color,
        ),
      Tabs.user => Image.asset(
          "assets/images/Memoji.png",
          width: size,
          height: size,
        ),
    };
  }

  String get title => switch (this) {
        Tabs.grid => LocaleKeys.grid,
        Tabs.project => LocaleKeys.projectSummary,
        Tabs.calendar => LocaleKeys.calendar,
        Tabs.user => LocaleKeys.account,
      };
}
