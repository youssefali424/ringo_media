import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/features/home/di/calendar_di.dart';

import '../../domain/entities/tabs.dart';
import 'add_event_content.dart';

class BaseHome extends ConsumerWidget {
  final Widget body;
  final Tabs selected;
  const BaseHome({
    super.key,
    required this.body,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, ref) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          shape: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: theme.colorScheme.outline, width: 1)),
          title: Text(selected.title.tr()),
          actions: [
            Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 24,
                      color: theme.primaryColor,
                    ).paddingAll(6.5),
                    PositionedDirectional(
                        end: 3,
                        top: 3.5,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                                color: theme.scaffoldBackgroundColor,
                                width: 1.5),
                            shape: BoxShape.circle,
                          ),
                        )),
                  ],
                ),
              ),
            ).paddingOnly(end: 24)
          ],
        ),
        drawer: const Drawer(),
        body: body,
        floatingActionButtonLocation: const CenterDockedFabLocation(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              var activeIndex = ref.read(calendarViewModelProvider
                  .select((state) => state.activeIndex));
              openBottomSheet(context, activeIndex);
            },
            shape: const CircleBorder(),
            isExtended: true,
            child: const Icon(Icons.add),
          );
        }),
        bottomNavigationBar: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          elevation: 20,
          child: BottomAppBar(
            elevation: 8,
            color: theme.scaffoldBackgroundColor,
            height: 88,
            shape: const AutomaticNotchedShape(RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Tabs.values.map((e) {
                var isSelected = e == selected;

                var notchMargin = EdgeInsetsDirectional.only(
                  end: e.index == 1 ? 30 : 0,
                  start: e.index == 2 ? 30 : 0,
                );
                return Padding(
                  padding: notchMargin,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).go('/home/${e.route}');
                    },
                    icon: e.icon(
                        color: isSelected
                            ? theme.primaryColor
                            : theme.colorScheme.secondary,
                        size: 24,
                        selected: isSelected),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context, int ativeIndex) async {
    var selectedDate = await showModalBottomSheet(
        context: context,
        showDragHandle: false,
        useRootNavigator: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (context) {
          return const AddEventContent();
        });
    if (selectedDate is DateTime && context.mounted) {
      var time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null && context.mounted) {
        ProviderScope.containerOf(context)
            .read(calendarViewModelProvider.notifier)
            .addTestEvent(selectedDate.copyWith(
                hour: time.hour, minute: time.minute, second: 0));
      }
    }
  }
}

class CenterDockedFabLocation extends StandardFabLocation
    with FabCenterOffsetX, FabDockedOffsetY {
  const CenterDockedFabLocation();
  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double contentMargin =
        scaffoldGeometry.scaffoldSize.height - contentBottom;
    final double bottomViewPadding = scaffoldGeometry.minViewPadding.bottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;
    final double bottomMinInset = scaffoldGeometry.minInsets.bottom;

    double safeMargin;

    if (contentMargin > bottomMinInset + fabHeight / 2.0) {
      // If contentMargin is higher than bottomMinInset enough to display the
      // FAB without clipping, don't provide a margin
      safeMargin = 0.0;
    } else if (bottomMinInset == 0.0) {
      // If bottomMinInset is zero(the software keyboard is not on the screen)
      // provide bottomViewPadding as margin
      safeMargin = bottomViewPadding;
    } else {
      // Provide a margin that would shift the FAB enough so that it stays away
      // from the keyboard
      safeMargin = fabHeight / 2.0 + kFloatingActionButtonMargin;
    }

    double fabY = contentBottom - fabHeight / 2.0 - safeMargin;
    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0) {
      fabY = math.min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    }
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0) {
      fabY =
          math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);
    }
    final double maxFabY =
        scaffoldGeometry.scaffoldSize.height - fabHeight - safeMargin;
    return math.min(maxFabY, fabY) + (fabHeight * 0.2);
  }

  @override
  String toString() => 'centerDockedCustom';
}
