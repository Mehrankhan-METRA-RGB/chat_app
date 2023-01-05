import 'package:chat_app/Presentation/common/app_shadow.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.error, Key? key}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.35,
          horizontal: MediaQuery.of(context).size.width * 0.07),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [AppShadow.normal()]),
      child: Text(
        error,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black54),
      ),
    );
  }
}
