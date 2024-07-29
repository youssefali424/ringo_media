import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/features/auth/login/presentation/widgets/auth_button.dart';
import 'package:collection/collection.dart';
import '../../domain/entities/auth_type.dart';

class AuthButtons extends StatelessWidget {
  final List<AuthType> authTypes;
  const AuthButtons({
    super.key,
    required this.authTypes,
  });

  @override
  Widget build(BuildContext context) {
    if (authTypes.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: authTypes
          .mapIndexed((i, e) => AuthButton(
                type: e,
              ).paddingOnly(bottom: i == authTypes.length - 1 ? 0 : 16))
          .toList(),
    );
  }
}
