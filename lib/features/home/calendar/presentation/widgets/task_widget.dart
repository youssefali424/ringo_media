import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:ringo_media/features/home/calendar/domain/entities/task.dart';
import 'package:ringo_media/generated/locale_keys.g.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final Function(bool)? onToggle;
  const TaskWidget({
    super.key,
    required this.task,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor.withOpacity(0.16),
                spreadRadius: 0,
                blurRadius: 24,
                offset: const Offset(4, 8)),
          ]),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: theme.medium.base,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${LocaleKeys.dueDate.tr()} : ${DateFormat("EEE, dd MMM yyyy", context.locale.languageCode).format(task.endDate)}",
                style:
                    theme.regular.xs.copyWith(color: const Color(0xFF697896)),
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
          Checkbox(
              value: task.done,
              activeColor: const Color(0xff5ECEB3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              // visualDensity: VisualDensity(
              // horizontal: VisualDensity.maximumDensity,
              // vertical: VisualDensity.maximumDensity),
              visualDensity: VisualDensity.compact,
              onChanged: (value) {
                onToggle?.call(value ?? false);
              }),
        ],
      ).paddingAll(16),
    );
  }
}
