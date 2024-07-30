import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_state.dart';

var emailRegex = RegExp(
    r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''');

class LoginViewModel extends StateNotifier<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginViewModel() : super(const LoginState()) {
    listenForControllers();
  }
  void listenForControllers() {
    emailController.addListener(() {
      var isEmpty = emailController.text.isEmpty;
      state = state.copyWith(
        buttonEnabled: !isEmpty && passwordController.text.isNotEmpty,
      );
    });
    passwordController.addListener(() {
      var isEmpty = passwordController.text.isEmpty;
      state = state.copyWith(
        buttonEnabled: !isEmpty && emailController.text.isNotEmpty,
      );
    });
  }

  togglePasswordVisibility() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }

  bool login() {
    if (emailRegex.hasMatch(emailController.text)) {
      state = state.copyWith(emailError: false);
      return true;
    }
    state = state.copyWith(emailError: true);
    return false;
  }
}
