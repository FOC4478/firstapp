import 'package:flutter/material.dart';
import 'package:my_first_app/utilities/genericdialogue.dart';

Future<void> showPasswordResetSentDialogue(BuildContext context) {
  return showGenericDialogue<void>(
    context: context,
    title: 'Password Reset',
    content: 'We have now sent you a password reset link. Please check your email',
    optionsBuilder: () => {
      'OK' : null,
    },
  );
}
