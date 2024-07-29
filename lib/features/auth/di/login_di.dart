import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ringo_media/features/auth/login/domain/entities/login_state.dart';

import '../login/presentation/view_models/login_view_model.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  throw UnimplementedError("loginViewModelProvider is not overriden");
});
