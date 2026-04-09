import 'package:flutter/material.dart';
import 'package:my_first_app/utilities/genericdialogue.dart';

Future<bool> showDeleteDialogue(BuildContext context) {
  return showGenericDialogue<bool>(
    context: context,
    title: 'Delete',
    content: 'Are You Sure You Want To Delet This Item?',
    optionsBuilder: () => {'Cancel': false, 'Yes': true},
  ).then((value) => value ?? false);
}
