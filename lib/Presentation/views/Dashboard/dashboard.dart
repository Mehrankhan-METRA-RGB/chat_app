import 'package:chat_app/Data/Repositories/AuthRepository/auth_repository.dart';
import 'package:chat_app/Presentation/common/app_bar.dart';
import 'package:chat_app/Presentation/common/network_image.dart';
import 'package:chat_app/Presentation/views/Chat/chat_screen.dart';
import 'package:chat_app/Presentation/views/Splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        isLeading: false,
        leadingButton: CacheImage(
          height: 45,
          width: 45,
          radius: 22.5,
          url: FirebaseAuth.instance.currentUser?.photoURL ?? ' ',
          errorImageUrl: 'assets/images/dummy_profile.png',
        ),
        button: IconButton(
          icon: const Icon(
            Icons.logout_sharp,
            color: Colors.black54,
          ),
          onPressed: () async {
            await AuthRepository.signOut()
                .then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                      (route) => false,
                    ));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen(myId: '1')));
                },
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'USER 1 Chat Screen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
              child: MaterialButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen(myId: '2')));
                },
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'USER 2 Chat Screen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
