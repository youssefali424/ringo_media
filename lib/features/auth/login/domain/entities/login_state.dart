import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../base/domain/entities/base_state.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState implements BaseBlocState {
  const factory LoginState({
    @Default(false) buttonEnabled,
    @Default(false) bool emailError,
    @Default(false) bool passwordVisible,
    @Default(false) bool isLoading,
    @Default(false) bool hasNoConnection,
    @Default("") String message,
  }) = _LoginState;
}
