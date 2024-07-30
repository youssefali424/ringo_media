// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "appName": "Ringo Media",
  "login": "Login",
  "register": "Register",
  "signInToYourAccount": "Sign in to your account",
  "orLoginWithAccount": "or continue with account",
  "username": "Username / Email",
  "enterUsernameOrEmail": "Enter Username or Email",
  "forgotPassword": "Forgot Password ?",
  "password": "Password",
  "enterPasswordHere": "Enter password here",
  "continueWithGoogle": "Continue with Google",
  "continueWithFacebook": "Continue with Facebook",
  "continueWithApple": "Continue with Apple",
  "dontHaveAnAccount": "Don't have an account ?",
  "registerHere": "Register here",
  "projectSummary": "Project Summary",
  "viewAllProjects": "View All Projects",
  "calendar": "Calendar",
  "schedule": "Schedule",
  "task": "Task",
  "emailError": "Please enter a valid email address",
  "grid": "Grid",
  "account": "Account",
  "search": "Search",
  "searchProjectHere": "Search project here",
  "projectInProgress": "Project In Progress",
  "projectCompleted": "Project Completed",
  "projectCancelled": "Project Cancelled",
  "productivty": "Productivity",
  "chooseDate": "Choose Date",
  "Continue": "Continue"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
