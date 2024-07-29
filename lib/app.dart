import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/navigation/routes.dart';

import 'generated/locale_keys.g.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      title: LocaleKeys.appName,
      theme: ThemeData(
          colorSchemeSeed: const Color(0xFF001B3E),
          appBarTheme: const AppBarTheme(centerTitle: true)),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     colorSchemeSeed: const Color(0xFF001B3E),
      //     appBarTheme: const AppBarTheme(centerTitle: true)),
      themeMode: ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: generateRoutes(),
    );
  }
}
