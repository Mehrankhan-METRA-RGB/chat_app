import 'package:chat_app/Application/Chat/chat_cubit.dart';
import 'package:chat_app/Application/Login/login_cubit.dart';
import 'package:chat_app/Application/Recording/recording_cubit.dart';
import 'package:chat_app/Application/Registration/registration_cubit.dart';
import 'package:chat_app/Data/Repositories/Notification/notification_repository.dart';
import 'package:chat_app/Presentation/views/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationRepository().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordingCubit>(
            create: (BuildContext context) => RecordingCubit()),
        BlocProvider<ChatCubit>(create: (BuildContext context) => ChatCubit()),
        BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit()),
        BlocProvider<RegistrationCubit>(
            create: (BuildContext context) => RegistrationCubit()),
      ],
      child: MaterialApp(
          title: 'Chat App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen()

          // const Dashboard(title: 'Chat App')

          ),
    );
  }
}
