import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/base_event.dart';
import 'package:ringo_media/features/home/calendar/presentation/view_models/events_view_mode.dart';
import 'package:ringo_media/features/home/calendar/presentation/view_models/tasks_view_mode.dart';

import '../../domain/entities/calendar_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/task.dart';

class CalendarViewModel extends StateNotifier<CalendarState> {
  EventsViewModel eventsViewModel;
  TasksViewModel tasksViewModel;
  CalendarViewModel(
      {required this.eventsViewModel, required this.tasksViewModel})
      : super(CalendarState(selectedDay: DateTime.now()));

  updateActiveIndex(int index) {
    state = state.copyWith(activeIndex: index);
  }

  void addEvent(BaseEvent event) {
    if (event is Event) {
      eventsViewModel.state = [...eventsViewModel.state, event];
    } else if (event is Task) {
      tasksViewModel.state = [...tasksViewModel.state, event];
    }
  }

  void selectedDay(DateTime date) {
    state = state.copyWith(selectedDay: date);
  }

  void addTestEvent(DateTime date) {
    if (state.activeIndex == 0) {
      addEvent(Event(
          title: "Meeting",
          endDate: date,
          startDate: date,
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)]));
    } else if (state.activeIndex == 1) {
      addEvent(Task(
        title: "Meeting",
        endDate: date,
        done: false,
      ));
    }
  }
}
