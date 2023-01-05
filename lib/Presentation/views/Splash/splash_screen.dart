import 'dart:async';

import 'package:chat_app/Data/Config/notification_config.dart';
import 'package:chat_app/Presentation/views/Auth/Login/login.dart';
import 'package:chat_app/Presentation/views/Dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> _sub;

  @override
  void initState() {
    super.initState();
    NotificationConfig().notificationPayload(context);
    _sub = FirebaseAuth.instance.authStateChanges().listen((event) {
      try {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => event != null
                    ? const Dashboard(
                        title: 'Chat App',
                      )
                    : const Login()));
      } catch (e) {
        rethrow;
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
                child: Center(
              child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent.withOpacity(0.4),
                    color: Colors.blueAccent,
                    strokeWidth: 6,
                  )),
            ));
          } else {
            bool isLogin =
                FirebaseAuth.instance.currentUser == null ? false : true;
            return isLogin
                ? const Dashboard(
                    title: 'Chat App',
                  )
                : const Login();
          }
        });
  }
}
