import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsViewModel extends StateNotifier<List<Event>> {
  EventsViewModel([List<Event>? allEvents]) : super(allEvents ?? <Event>[]);

  Map<TimeOfDay, Event> eventsByDay(List<Event> allEvents, DateTime day) {
    var events = <TimeOfDay, Event>{};
    for (var event in allEvents) {
      if (isSameDay(day, event.startDate)) {
        var eventTime = TimeOfDay.fromDateTime(event.startDate);
        events[eventTime] = event;
      }
    }
    return events;
  }
}
