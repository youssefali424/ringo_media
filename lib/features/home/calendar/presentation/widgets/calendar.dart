import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final void Function(DateTime)? onDaySelected;
  const Calendar({
    super.key,
    this.onDaySelected,
  });

  @override
  State<Calendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<Calendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();

    // _focusedDay = DateTime(_focusedDay.year, 9, _focusedDay.day);
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var theme = Theme.of(context);
    const weekStart = StartingDayOfWeek.monday;
    return TableCalendar(
        firstDay: DateTime.utc(1990, 10, 16),
        lastDay: DateTime.utc(today.year + 20, 12, 30),
        focusedDay: _focusedDay,
        onCalendarCreated: (pageController) {
          this.pageController = pageController;
        },
        rowHeight: 38,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: weekStart,
        headerStyle: const HeaderStyle(
            leftChevronVisible: false,
            headerPadding: EdgeInsets.zero,
            headerMargin: EdgeInsets.zero,
            rightChevronVisible: false,
            formatButtonVisible: false),
        daysOfWeekVisible: false,
        // daysOfWeekStyle: DaysOfWeekStyle(),
        calendarStyle: CalendarStyle(
          // tablePadding: EdgeInsets.zero,
          // cellPadding: EdgeInsets.zero,
          cellMargin: EdgeInsets.only(bottom: 12),
          selectedTextStyle:
              theme.semiBold.base.copyWith(color: theme.colorScheme.onPrimary),
          todayTextStyle:
              theme.semiBold.base.copyWith(color: theme.colorScheme.onPrimary),
          defaultTextStyle: theme.semiBold.base,
          weekendTextStyle: theme.semiBold.base,
          holidayTextStyle: theme.semiBold.base,
          disabledTextStyle:
              theme.semiBold.base.copyWith(color: theme.disabledColor),
          outsideTextStyle:
              theme.semiBold.base.copyWith(color: theme.disabledColor),
          selectedDecoration:
              BoxDecoration(color: theme.primaryColor, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.4),
              shape: BoxShape.circle),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return header(weekStart, day, context);
          },
          // dowBuilder: (context, day) {
          //   // return header(weekStart, day, context);
          //   return const SizedBox.shrink();
          // },
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
          widget.onDaySelected?.call(_selectedDay);
        });
  }

  DateTime getWeekdayName(int weekday) {
    final DateTime now = DateTime.now().toLocal();
    final int diff = now.weekday - weekday; // weekday is our 1-7 ISO value
    DateTime udpatedDt;
    if (diff > 0) {
      udpatedDt = now.subtract(Duration(days: diff));
    } else if (diff == 0) {
      udpatedDt = now;
    } else {
      udpatedDt = now.add(Duration(days: diff * -1));
    }
    // final String weekdayName = DateFormat('EEEE').format(udpatedDt);
    return udpatedDt;
  }

  Widget header(
      StartingDayOfWeek weekStart, DateTime day, BuildContext context) {
    var theme = Theme.of(context);
    var date = DateFormat("MMMM yyyy", context.locale.languageCode).format(day);
    return Column(
      children: [
        Row(
          children: List.generate(DateTime.daysPerWeek, (i) {
            // var lastDayIndex = (weekStart.index + 6) % 7;
            return Expanded(
              child: Center(
                child: Text(
                  DateFormat('EEEE', context.locale.languageCode)
                      .format(getWeekdayName((weekStart.index + i + 1) % 7))
                      .characters
                      .first,
                  style: theme.bold.base,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                pageController?.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: theme.colorScheme.primary,
              ).paddingAll(8),
            ),
            Expanded(
              child: Center(
                child: Text(
                  date,
                  style: theme.bold.lg,
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                pageController?.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: theme.colorScheme.primary,
              ).paddingAll(8),
            ),
          ],
        ),
      ],
    );
  }
}
