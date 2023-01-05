import 'package:chat_app/Application/Login/login_cubit.dart';
import 'package:chat_app/Presentation/common/app_bar.dart';
import 'package:chat_app/Presentation/common/app_button.dart';
import 'package:chat_app/Presentation/common/app_error.dart';
import 'package:chat_app/Presentation/common/app_loading.dart';
import 'package:chat_app/Presentation/common/app_text_field.dart';
import 'package:chat_app/Presentation/views/Auth/Registration/registration.dart';
import 'package:chat_app/Presentation/views/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordHidden = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Login',
          isLeading: false,
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoaded) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Dashboard(title: 'Chat App')));
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const LoadingScreen();
            }
            if (state is LoginError) {
              return ErrorScreen(error: state.error!);
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    AppTextField(
                        controller: _emailController,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black12,
                          size: 18,
                        ),
                        hintText: 'Enter email',
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                        controller: _passwordController,
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black12,
                              size: 18,
                            )),
                        obscureText: true,
                        hintText: 'Enter password',
                        textInputType: TextInputType.visiblePassword),
                    AppButton(
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          await context.read<LoginCubit>().login(
                              _emailController.text, _passwordController.text);
                        }
                      },
                      text: 'SignIn',
                      verticalMargin: 45,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Registration()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.blueAccent,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
