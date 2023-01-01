import 'package:flutter/material.dart';

class AppShadow {
  static BoxShadow normal() => BoxShadow(
        blurRadius: 15,
        spreadRadius: 5,
        color: Colors.black54.withOpacity(0.1),
        offset: const Offset(0, 7),
      );

  static BoxShadow minimum() => BoxShadow(
        blurRadius: 7,
        spreadRadius: 2,
        color: Colors.grey.withOpacity(0.1),
        offset: const Offset(0, 3),
      );
}
