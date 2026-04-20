import 'package:flutter/material.dart';
import 'package:my_first_app/utilities/genericdialogue.dart';

Future<void> showCannotShareEmptyNoteDialogue(BuildContext context) {
  return showGenericDialogue<void>(
    context: context,
    title: 'Sharing',
    content: 'You Cannot Share An Empty Note',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
