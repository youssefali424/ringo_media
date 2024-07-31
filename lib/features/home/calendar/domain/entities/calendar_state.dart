import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ringo_media/features/base/domain/entities/base_state.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState implements BaseState {
  const factory CalendarState({
    @Default(0) int activeIndex,
    required DateTime selectedDay,
    @Default(false) bool isLoading,
    @Default(false) bool hasNoConnection,
    @Default("") String message,
  }) = _CalendarState;
}
