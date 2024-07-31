import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/calendar_state.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/task.dart';
import 'package:ringo_media/features/home/calendar/presentation/view_models/calendar_view_model.dart';
import 'package:ringo_media/features/home/calendar/presentation/view_models/events_view_mode.dart';

import '../calendar/domain/entities/event.dart';
import '../calendar/presentation/view_models/tasks_view_mode.dart';

final eventsModelProvider =
    StateNotifierProvider<EventsViewModel, List<Event>>((ref) {
  DateTime withHour(DateTime date, int hour) {
    return DateTime(date.year, date.month, date.day, hour);
  }

  return EventsViewModel([
    Event(
        title: "Sprint Review Period 02 in May 2022",
        endDate: withHour(DateTime.now(), 11),
        startDate: withHour(DateTime.now(), 10),
        color: const Color(0xFFD08CDF)),
    Event(
        title: "Meeting with Client",
        endDate: withHour(DateTime.now(), 14),
        startDate: withHour(DateTime.now(), 13),
        color: const Color(0xFFFD7722)),
    Event(
        title: "Daily Standup",
        endDate: withHour(DateTime.now(), 15),
        startDate: withHour(DateTime.now(), 14),
        color: const Color(0xFF5ECEB3)),
  ]);
});

final tasksModelProvider =
    StateNotifierProvider<TasksViewModel, List<Task>>((ref) {
  return TasksViewModel([
    Task(title: "Meeting Concept", endDate: DateTime.now(), done: true),
    Task(
        title: "Information Architecture", endDate: DateTime.now(), done: true),
    Task(title: "Monitoring Project", endDate: DateTime.now(), done: true),
    Task(title: "Daily Standup", endDate: DateTime.now(), done: true),
  ]);
});

final calendarViewModelProvider =
    StateNotifierProvider<CalendarViewModel, CalendarState>((ref) {
  return CalendarViewModel(
    eventsViewModel: ref.watch(eventsModelProvider.notifier),
    tasksViewModel: ref.watch(tasksModelProvider.notifier),
  );
});
