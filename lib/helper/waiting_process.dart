import 'package:flutter/material.dart';
import '../loading_screen.dart';

class WaitingProcess {
  static void show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const LoadingScreen();
        });
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
