import 'package:flutter/material.dart';
import 'package:ringo_media/core/extensions/widgets/padding.dart';
import 'package:ringo_media/core/theme/font_extension.dart';

import '../../domain/entities/auth_type.dart';

class AuthButton extends StatelessWidget {
  final AuthType type;
  const AuthButton({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: theme.colorScheme.outline),
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Stack(
              children: [
                Positioned(
                    child: Image.asset(
                  type.image,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                )),
                Positioned(
                  right: 0,
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      type.text,
                      style: theme.bold.lg,
                    ),
                  ),
                )
              ],
            ).paddingAll(16)));
  }
}
