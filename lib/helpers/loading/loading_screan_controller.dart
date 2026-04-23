import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UploadLoadingScreen = bool Function(String text);

@immutable
class LoadingScreanController {
  final CloseLoadingScreen close;
  final UploadLoadingScreen update;

const  LoadingScreanController({required this.close, required this.update});
}
