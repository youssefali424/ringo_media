import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalendar extends StatefulWidget {
  final DateTime? selectedDay;
  final void Function(DateTime)? onDaySelected;
  const WeekCalendar({
    super.key,
    this.selectedDay,
    this.onDaySelected,
  });

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay ?? DateTime.now();
    _focusedDay = widget.selectedDay ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var theme = Theme.of(context);
    return TableCalendar(
        firstDay: DateTime.utc(1990, 10, 16),
        lastDay: DateTime.utc(today.year + 20, 12, 30),
        focusedDay: _focusedDay,
        onCalendarCreated: (pageController) {
          this.pageController = pageController;
        },
        rowHeight: 68,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        calendarFormat: CalendarFormat.week,
        headerStyle: const HeaderStyle(
            leftChevronVisible: false,
            rightChevronVisible: false,
            formatButtonVisible: false),
        calendarBuilders: CalendarBuilders(
          // prioritizedBuilder: ,

          headerTitleBuilder: (context, day) {
            var date = DateFormat("MMMM yyyy", context.locale.languageCode)
                .format(day);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      date,
                      style: theme.bold.lg,
                    ).paddingOnly(end: 3),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: theme.colorScheme.primary,
                      size: 24,
                    )
                  ],
                ),
                Row(children: [
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: theme.colorScheme.outline,
                        )),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        pageController?.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ).paddingAll(8),
                    ),
                  ).paddingOnly(end: 8),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: theme.colorScheme.outline,
                        )),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        pageController?.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ).paddingAll(8),
                    ),
                  ),
                ])
              ],
            ).paddingSymmetric(horizontal: 24);
          },
          prioritizedBuilder: (context, day, focusedDay) {
            var isFocused = isSameDay(focusedDay, day);
            return Material(
              borderRadius: BorderRadius.circular(10),
              color: isFocused ? theme.primaryColor : theme.colorScheme.surface,
              child: SizedBox(
                width: 50,
                child: Column(
                  children: [
                    Text(
                      DateFormat.E(context.locale.languageCode)
                          .format(day)
                          .toUpperCase(),
                      style: theme.bold.xs.copyWith(
                        color: isFocused
                            ? theme.colorScheme.surface
                            : theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.day.toString(),
                      style: theme.bold.base.copyWith(
                        color: isFocused ? theme.colorScheme.surface : null,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 8, vertical: 12),
              ),
            );
          },
          dowBuilder: (context, day) {
            return const SizedBox.shrink();
          },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });

          widget.onDaySelected?.call(selectedDay);
        });
  }
}
