import 'package:flutter/material.dart';
import 'package:my_first_app/utilities/genericdialogue.dart';

Future<bool> showLogOutDialogue(BuildContext context) {
  return showGenericDialogue<bool>(
    context: context,
    title: 'Log Out',
    content: 'Are You Sure You Want To Log Out?',
    optionsBuilder: () => {'Cancel': false, 'Log Out': true},
  ).then((value) => value ?? false);
}
