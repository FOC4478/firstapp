import 'package:flutter/material.dart';
import 'package:my_first_app/utilities/genericdialogue.dart';

Future<void> showErrorDialogue(
  BuildContext context, 
  String text,
  ) {
  return showGenericDialogue<void>(
    context: context,
    title: 'An Error Occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
