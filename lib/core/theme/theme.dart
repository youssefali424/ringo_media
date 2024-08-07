import 'package:flutter/material.dart';

const primary = Color(0xFF191D2B);

const MaterialColor swatch = MaterialColor(
  0xFF191D2B,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFF6F7F8),
    200: Color(0xFFE8EAEE),
    300: Color(0xFFD0D5DC),
    400: Color(0xFFB6BEC9),
    500: Color(0xff96A0B5),
    600: Color(0xFF697896),
    700: Color(0xFF121F3E),
    800: Color(0xFF21273B),
    900: primary,
  },
);
ThemeData generateLightTheme() {
  const secondary = Color(0xff96A0B5);
  const disabledColor = Color(0xFFD0D5DC);
  var colorScheme = ColorScheme.fromSwatch(
    primarySwatch: swatch,
    backgroundColor: swatch[50],
  ).copyWith(
    secondary: secondary,
    outline: swatch[200],
  );
  InputBorder inputBorder(Color color) =>
      UnderlineInputBorder(borderSide: BorderSide(color: color));
  return ThemeData(
    colorScheme: colorScheme,
    primaryColor: primary,
    disabledColor: disabledColor,

    /// text theme isnt clear in desgin "style guidelines"
    /// flutter follows material design and its guidelines
    /// but in design i couldn't match material design with
    /// the given style guidelines in Figma
    /// which is why i depend on custom font handling
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      labelLarge: TextStyle(),
      labelMedium: TextStyle(),
      labelSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
    ).apply(
      bodyColor: primary,
      displayColor: primary,
      fontFamily: "Urbanist",
      decorationColor: primary,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return primary;
      }),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
    )),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }
        return primary;
      }),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
    )),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: primary,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: const TextStyle(
        color: primary,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      ),
      // alignLabelWithHint: true,

      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: const TextStyle(
        color: secondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      border: inputBorder(secondary),
      focusedBorder: inputBorder(primary),
      errorBorder: inputBorder(colorScheme.error),
      enabledBorder: inputBorder(secondary),
      disabledBorder: inputBorder(disabledColor),
      suffixIconColor: secondary,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: swatch[100],
        titleTextStyle: const TextStyle(
            color: primary,
            fontFamily: "Urbanist",
            fontSize: 16,
            fontWeight: FontWeight.bold)),
    tabBarTheme: const TabBarTheme(
        // tabAlignment: TabAlignment.fill,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: primary,
        unselectedLabelColor: secondary,
        unselectedLabelStyle: TextStyle(
            color: primary,
            fontFamily: "Urbanist",
            fontSize: 18,
            fontWeight: FontWeight.bold),
        labelStyle: TextStyle(
            color: primary,
            fontFamily: "Urbanist",
            fontSize: 18,
            fontWeight: FontWeight.bold)),
    dividerTheme: DividerThemeData(color: swatch[200]),
  );
}
