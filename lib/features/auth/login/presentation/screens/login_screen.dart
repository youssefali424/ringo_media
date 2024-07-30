import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';
import 'package:ringo_media/features/auth/di/login_di.dart';
import 'package:ringo_media/features/auth/login/presentation/view_models/login_view_model.dart';
import 'package:ringo_media/features/home/project/domain/entities/tabs.dart';
import 'package:ringo_media/generated/locale_keys.g.dart';

import '../../domain/entities/auth_type.dart';
import '../widgets/auth_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        loginViewModelProvider.overrideWith(
          (ref) => LoginViewModel(),
        )
      ],
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends ConsumerWidget {
  const _LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var theme = Theme.of(context);
    var viewModel = ref.watch(loginViewModelProvider.notifier);
    return SafeArea(
        child: Scaffold(
            body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.login.tr(),
                style: Theme.of(context).bold.xl,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.signInToYourAccount.tr(),
                style: Theme.of(context).medium.sm.secondary,
              ),
              const SizedBox(height: 40),
              Consumer(builder: (context, ref, child) {
                var emailError = ref.watch(
                    loginViewModelProvider.select((value) => value.emailError));
                return TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.username.tr(),
                    hintText: LocaleKeys.enterUsernameOrEmail.tr(),
                    errorText: emailError ? LocaleKeys.emailError.tr() : null,
                  ),
                );
              }),
              Consumer(builder: (context, ref, child) {
                var passwordVisible = ref.watch(loginViewModelProvider
                    .select((value) => value.passwordVisible));
                return TextField(
                  controller: viewModel.passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                      labelText: LocaleKeys.password.tr(),
                      hintText: LocaleKeys.enterPasswordHere.tr(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref
                              .read(loginViewModelProvider.notifier)
                              .togglePasswordVisibility();
                        },
                        icon: passwordVisible
                            ? Icon(Icons.visibility,
                                color:
                                    theme.inputDecorationTheme.hintStyle?.color)
                            : Icon(Icons.visibility_off,
                                color: theme
                                    .inputDecorationTheme.hintStyle?.color),
                      )),
                ).paddingSymmetric(vertical: 24);
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.forgotPassword.tr(),
                    style: Theme.of(context).semiBold.sm,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer(builder: (context, ref, _) {
                      var enabled = ref.watch(loginViewModelProvider
                          .select((value) => value.buttonEnabled));
                      return FilledButton(
                        onPressed: enabled
                            ? () {
                                var success = ref
                                    .read(loginViewModelProvider.notifier)
                                    .login();
                                if (success) {
                                  GoRouter.of(context).go('/home/${Tabs.project.route}');
                                }
                              }
                            : null,
                        child: Text(LocaleKeys.login.tr()),
                      );
                    }),
                  ),
                ],
              ).paddingSymmetric(vertical: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.orLoginWithAccount.tr(),
                    style: Theme.of(context).semiBold.sm.secondary,
                  ),
                ],
              ).paddingOnly(bottom: 24),
              const AuthButtons(
                authTypes: [AuthType.google, AuthType.facebook, AuthType.apple],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.dontHaveAnAccount.tr(),
                    style: Theme.of(context).medium.sm.secondary,
                  ),
                  Text(
                    LocaleKeys.registerHere.tr(),
                    style: Theme.of(context).bold.sm,
                  ).paddingOnly(start: 4),
                ],
              ).paddingOnly(top: 40),
            ],
          )),
    )));
  }
}
