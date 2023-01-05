import 'dart:io';

import 'package:chat_app/Application/Registration/registration_cubit.dart';
import 'package:chat_app/Presentation/common/ContextWidgets/app_dialog.dart';
import 'package:chat_app/Presentation/common/app_bar.dart';
import 'package:chat_app/Presentation/common/app_button.dart';
import 'package:chat_app/Presentation/common/app_error.dart';
import 'package:chat_app/Presentation/common/app_loading.dart';
import 'package:chat_app/Presentation/common/app_text_field.dart';
import 'package:chat_app/Presentation/views/Auth/Login/login.dart';
import 'package:chat_app/Presentation/views/Dashboard/dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  PlatformFile? _profileImage;
  bool isPasswordHidden = true;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Registration',
        isLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: BlocConsumer<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationLoaded) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Dashboard(title: 'Chat App')));
              } else if (state is RegistrationError) {
                AppDialog.show(context,
                    child: ErrorScreen(error: state.error!));
              }
            },
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return const LoadingScreen();
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                foregroundImage: _profileImage == null
                                    ? const AssetImage(
                                        'assets/images/dummy_profile.png')
                                    : null,
                                backgroundImage: _profileImage != null
                                    ? FileImage(File(_profileImage!.path!))
                                    : null,
                                backgroundColor:
                                    Colors.blueAccent.withOpacity(0.4),
                                radius: 50,
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.blueAccent,
                                    size: 25,
                                  ),
                                  onPressed: () => pickImage(),
                                ))
                          ],
                        ),
                      ),
                      AppTextField(
                          controller: _nameController,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black12,
                            size: 18,
                          ),
                          hintText: 'Enter name',
                          textInputType: TextInputType.name),
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
                      AppTextField(
                          controller: _confirmPasswordController,
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
                          hintText: 'Confirm password',
                          textInputType: TextInputType.visiblePassword),
                      AppButton(
                        onTap: () {
                          if (_confirmPasswordController.text ==
                              _passwordController.text) {
                            if (key.currentState!.validate()) {
                              context.read<RegistrationCubit>().register({
                                'file': File(_profileImage!.path!),
                                'name': _nameController.text,
                                'email': _emailController.text,
                                'password': _passwordController.text,
                                'confirm_password': _passwordController.text,
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Center(
                                child: Text(
                                  'Password and confirm password not matched',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              backgroundColor: Colors.redAccent,
                            ));
                          }
                        },
                        text: 'SignUp',
                        verticalMargin: 45,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
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
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Sign In",
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
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _profileImage = result.files.first;
      });
    }
  }
}
