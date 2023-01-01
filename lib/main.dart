import 'package:chat_app/Application/Chat/chat_cubit.dart';
import 'package:chat_app/Application/Recording/recording_cubit.dart';
import 'package:chat_app/Presentation/views/Chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordingCubit>(
            create: (BuildContext context) => RecordingCubit()),
        BlocProvider<ChatCubit>(create: (BuildContext context) => ChatCubit()),
      ],
      child: MaterialApp(
          title: 'Chat App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const InitialScreen(title: 'Chat App')
          // AudioRecorder(
          //   onStop: (String path) {
          //     print(path);
          //   },ChatScreen
          // ),
          ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key, required this.title});

  final String title;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
