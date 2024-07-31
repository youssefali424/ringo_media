import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/event.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  const EventWidget({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var secondaryColor = theme.colorScheme.secondary;
    String formateDate(DateTime date) {
      DateFormat formatter = DateFormat('h:mm a', context.locale.languageCode);
      return formatter.format(date);
    }

    return Container(
        decoration: BoxDecoration(
            color: event.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: BorderDirectional(
                start: BorderSide(color: event.color, width: 6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: theme.semiBold.sm,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: secondaryColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  "${formateDate(event.startDate)} - ${formateDate(event.endDate)}",
                  style: theme.medium.xs.copyWith(
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 12));
  }
}
