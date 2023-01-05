import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, Key? key}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      error,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black54),
    ));
  }
}
