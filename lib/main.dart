import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'app.dart';
import 'core/language/supported.dart';
import 'generated/codegen_loader.g.dart';
// import 'core/di/currency_conversion_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  await EasyLocalization.ensureInitialized();
  runApp(ProviderScope(
    // overrides: [
    //   // hiveCurrenciesBoxProvider
    //   //     .overrideWithValue(await Hive.openBox('currencies'))
    // ],
    child: EasyLocalization(
        supportedLocales: SupportedLanguage.supportedLocales,
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const MyApp()),
  ));
}
