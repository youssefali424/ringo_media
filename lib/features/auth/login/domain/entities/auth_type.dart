import 'package:easy_localization/easy_localization.dart';

import '../../../../../generated/locale_keys.g.dart';

enum AuthType {
  login,
  register,
  google,
  facebook,
  apple;

  String get image => switch (this) {
        AuthType.google => "assets/images/Google.png",
        AuthType.apple => "assets/images/Apple.png",
        AuthType.facebook => "assets/images/Facebook.png",
        _ => "",
      };
  String get text => switch (this) {
        AuthType.login => LocaleKeys.login.tr(),
        AuthType.register => LocaleKeys.register.tr(),
        AuthType.google => LocaleKeys.continueWithGoogle.tr(),
        AuthType.apple => LocaleKeys.continueWithApple.tr(),
        AuthType.facebook => LocaleKeys.continueWithFacebook.tr(),
      };
}
