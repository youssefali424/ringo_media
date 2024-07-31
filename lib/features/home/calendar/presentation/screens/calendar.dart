import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/features/home/calendar/presentation/widgets/event_widget.dart';
import 'package:ringo_media/features/home/calendar/presentation/widgets/task_widget.dart';
import 'package:ringo_media/features/home/calendar/presentation/widgets/time_line/time_line.dart';
import 'package:ringo_media/features/home/di/calendar_di.dart';
import 'package:ringo_media/generated/locale_keys.g.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/week_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      ProviderScope.containerOf(context)
          .read(calendarViewModelProvider.notifier)
          .updateActiveIndex(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Material(
              color: theme.appBarTheme.backgroundColor,
              child: Column(
                children: [
                  Consumer(builder: (context, ref, child) {
                    var selectedDay = ref.watch(calendarViewModelProvider
                        .select((state) => state.selectedDay));
                    return WeekCalendar(
                        selectedDay: selectedDay,
                        onDaySelected: (date) {
                          ref
                              .read(calendarViewModelProvider.notifier)
                              .selectedDay(date);
                        }).paddingOnly(top: 20);
                  }),
                  TabBar(controller: tabController, tabs: [
                    Tab(
                      icon: Text(LocaleKeys.schedule.tr()),
                    ),
                    Tab(icon: Text(LocaleKeys.task.tr())),
                  ]).paddingOnly(top: 24).paddingSymmetric(horizontal: 24),
                ],
              )),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              Consumer(builder: (context, ref, child) {
                var events = ref.watch(eventsModelProvider);
                var selectedDay = ref.watch(calendarViewModelProvider
                    .select((state) => state.selectedDay));

                return TimeLine(
                  itemHeight: 72,
                  showCurrentTime: isSameDay(selectedDay, DateTime.now()),
                  children: ref
                      .watch(eventsModelProvider.notifier)
                      .eventsByDay(events, selectedDay)
                      .map((time, event) {
                    return MapEntry(time, EventWidget(event: event));
                  }),
                );
              }),
              Consumer(builder: (context, ref, child) {
                var tasks = ref.watch(tasksModelProvider);
                var selectedDay = ref.watch(calendarViewModelProvider
                    .select((state) => state.selectedDay));
                tasks = tasks.where((task) {
                  return isSameDay(selectedDay, task.endDate);
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (_, i) => TaskWidget(
                    task: tasks[i],
                    onToggle: (isDone) => ref
                        .read(tasksModelProvider.notifier)
                        .toggleTask(i, isDone),
                  ).paddingOnly(bottom: 16),
                  itemCount: tasks.length,
                );
              })
            ]),
          ),
        ],
      ),
    );
  }
}
