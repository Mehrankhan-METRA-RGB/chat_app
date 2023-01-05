import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
          backgroundColor: Colors.blueAccent.withOpacity(0.4),
          strokeWidth: 5,
        ),
      ),
    );
  }
}
