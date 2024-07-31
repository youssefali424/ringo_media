import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ringo_media/navigation/routes.dart';

import 'core/theme/theme.dart';
import 'generated/locale_keys.g.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var routes = generateRoutes();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: LocaleKeys.appName,
      debugShowCheckedModeBanner: false,
      theme: generateLightTheme(),
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     colorSchemeSeed: const Color(0xFF001B3E),
      //     appBarTheme: const AppBarTheme(centerTitle: true)),
      themeMode: ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: routes,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!),
        );
      },
    );
  }
}
