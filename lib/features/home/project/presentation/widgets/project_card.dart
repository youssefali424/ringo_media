import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final int count;
  final Widget? icon;
  final List<Color> colors;
  const ProjectCard({
    super.key,
    required this.colors,
    required this.title,
    required this.count,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Material(
      elevation: 10,
      shadowColor: colors.first.withOpacity(0.7),
      color: Colors.transparent,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [
              //   BoxShadow(
              //       color: colors.first.withOpacity(0.5),
              //       offset: const Offset(0, 5),
              //       spreadRadius: 10,
              //       // blurStyle: BlurStyle.inner,
              //       blurRadius: 2)
              // ],
              gradient: RadialGradient(
                  colors: colors,
                  radius: 1,
                  tileMode: TileMode.clamp,
                  // focalRadius: 0.1,
                  center: AlignmentDirectional.centerStart,
                  focal: AlignmentDirectional.topStart)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count.toString(),
                    style: theme.bold.xl.copyWith(color: Colors.white),
                  ).paddingOnly(end: 8),
                  icon ?? const SizedBox(),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: theme.medium.xs.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
