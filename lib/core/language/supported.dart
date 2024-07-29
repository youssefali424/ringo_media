import 'dart:ui';

enum SupportedLanguage {
  en;

  static SupportedLanguage fromString(String language) {
    switch (language) {
      case 'en':
        return SupportedLanguage.en;
      default:
        return SupportedLanguage.en;
    }
  }

  static SupportedLanguage fromLocale(Locale language) {
    return fromString(language.languageCode);
  }

  static List<Locale> get supportedLocales {
    return [
      SupportedLanguage.en.locale,
    ];
  }

  String get translate {
    switch (this) {
      case SupportedLanguage.en:
        return 'English';
    }
  }

  Locale get locale {
    return Locale(name);
  }
}
