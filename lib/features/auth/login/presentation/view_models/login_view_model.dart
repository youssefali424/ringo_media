import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/login_state.dart';

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
        emailError: isEmpty,
        buttonEnabled: !isEmpty && passwordController.text.isNotEmpty,
      );
    });
    passwordController.addListener(() {
      var isEmpty = passwordController.text.isEmpty;
      state = state.copyWith(
        passwordError: isEmpty,
        buttonEnabled: !isEmpty && emailController.text.isNotEmpty,
      );
    });
  }

  togglePasswordVisibility() {
    state = state.copyWith(passwordVisible: !state.passwordVisible);
  }
}
