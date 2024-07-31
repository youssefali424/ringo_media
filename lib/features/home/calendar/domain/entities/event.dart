import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/base_event.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event implements BaseEvent {
  const factory Event({
    required String title,
    required DateTime endDate,
    required DateTime startDate,
    required Color color,
  }) = _Event;
}
