import 'package:flutter/material.dart';

class AppDialog {
  static show(BuildContext context, {required Widget child}) {
    showDialog(context: context, builder: (context) => child);
  }
}
