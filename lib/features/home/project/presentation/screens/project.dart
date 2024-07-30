import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:ringo_media/features/home/project/presentation/widgets/project_card.dart';
import 'package:ringo_media/generated/locale_keys.g.dart';
import 'package:collection/collection.dart';

import '../widgets/months_chart.dart';

var random = Random();

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Material(
            color: theme.appBarTheme.backgroundColor,
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  labelText: LocaleKeys.search.tr(),
                  hintText: LocaleKeys.searchProjectHere.tr(),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Icon(Icons.search),
                  ),
                  // suffix: const Icon(Icons.search),
                ),
              ).paddingOnly(bottom: 24),
              Row(
                children: [
                  Expanded(
                      child: ProjectCard(
                          colors: const [
                        Color(0xff3A9ADE),
                        Color(0xff5EACE4),
                      ],
                          title: LocaleKeys.projectInProgress.tr(),
                          count: 10,
                          icon: const Icon(
                            Icons.access_time_filled,
                            color: Colors.white,
                            size: 16,
                          ))),
                  Expanded(
                      child: ProjectCard(
                          colors: const [
                        Color(0xff3F8B8D),
                        Color(0xff58B2B4),
                      ],
                          title: LocaleKeys.projectCompleted.tr(),
                          count: 24,
                          icon: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ))),
                  Expanded(
                      child: ProjectCard(
                          colors: const [
                        Color(0xffDD4A4A),
                        Color(0xffE87777),
                      ],
                          title: LocaleKeys.projectCancelled.tr(),
                          count: 5,
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 16,
                          ))),
                ]
                    .mapIndexed(
                        (i, e) => [e, if (i != 2) const SizedBox(width: 8)])
                    .expand((e) => e)
                    .toList(),
              ),
              Row(
                children: [
                  Expanded(
                      child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: theme.colorScheme.primary, width: 1.5),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: Text(
                          LocaleKeys.viewAllProjects.tr(),
                          style: theme.bold.sm,
                        ).paddingAll(14),
                      ),
                    ),
                  ))
                ],
              ).paddingOnly(top: 24),
            ]).paddingAll(24),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.productivty.tr(),
                    style: theme.bold.lg,
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 24,
                    color: theme.primaryColor,
                  )
                ],
              ),
              MonthsChart(
                monthsData: Map.fromEntries(List.generate(12,
                    (index) => MapEntry(index + 1, random.nextDouble() * 100))),
              )
            ],
          ).paddingAll(24)
        ],
      ),
    ));
  }
}
