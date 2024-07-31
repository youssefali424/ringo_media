import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/base_event.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task implements BaseEvent {
  const factory Task({
    required String title,
    required DateTime endDate,
    @Default(false) bool done,
  }) = _Task;
}
