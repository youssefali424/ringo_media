import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../calendar/presentation/widgets/calendar.dart';

class AddEventContent extends StatefulWidget {
  const AddEventContent({super.key});

  @override
  State<AddEventContent> createState() => _AddEventContentState();
}

class _AddEventContentState extends State<AddEventContent> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Wrap(
      children: [
        Stack(
          fit: StackFit.passthrough,
          children: [
            Center(
              child: Text(
                LocaleKeys.chooseDate.tr(),
                style: theme.bold.base,
              ).paddingSymmetric(vertical: 18),
            ),
            PositionedDirectional(
              end: 8,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            )
          ],
        ),
        const Divider(height: 1),
        Calendar(onDaySelected: (date) {
          selectedDate = date;
        }).paddingSymmetric(vertical: 24, horizontal: 24),
        const Divider(height: 1),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedDate);
                  },
                  child: Text(LocaleKeys.Continue.tr()))
              .paddingSymmetric(vertical: 24, horizontal: 24),
        ),
      ],
    );
  }
}
