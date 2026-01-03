import 'dart:io';
import 'package:allah_ho_allam_flutter/views/auth/verification_code.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_rounded_button.dart';
import '../../widgets/top_heading_and_description.dart';
import '../viewModel/signUpViewModel.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final nameFieldKey = GlobalKey<CustomTextFieldState>();
  final emailFieldKey = GlobalKey<CustomTextFieldState>();
  final passwordFieldKey = GlobalKey<CustomTextFieldState>();
  final confirmPasswordFieldKey = GlobalKey<CustomTextFieldState>();

  SignUpScreen({super.key});

  Future<void> getDeviceIdAndSignUp(WidgetRef ref) async {
    final deviceInfo = DeviceInfoPlugin();

    String? deviceId;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Unique Android ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor; // Unique iOS ID
    }
    ref
        .read(authProvider.notifier)
        .signUp(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          deviceId!, // pass it here
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (msg) {
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: Colors.green),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VerificationCode()),
            );
          }
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_primary.png"),
            // your background image
            fit: BoxFit.cover, // cover = fill entire screen
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // wrap with SingleChildScrollView
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft, // 👈 places button at start
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: BackButtonSvg(
                      iconPath: "assets/images/ic_back.svg",
                      onTap: () => Navigator.pop(context), // 👈 handle click
                    ),
                  ),
                ),

                SizedBox(height: 100), // space between texts
                TopHeadingAndDescription(
                  title: "Sign Up",
                  decription: "Please fill the required fields",
                ),
                SizedBox(height: 30), // space between texts
                CustomTextField(
                  key: nameFieldKey,
                  hintText: "Enter your name",
                  iconPath: "assets/images/ic_lock.svg",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  key: emailFieldKey,
                  hintText: "Enter your email",
                  iconPath: "assets/images/ic_mail.svg",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    final emailRegex = RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) return "Enter valid email";
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  key: passwordFieldKey,
                  hintText: "Enter your password",
                  iconPath: "assets/images/ic_lock.svg",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter password";
                    if (value.length < 6)
                      return "Password must be at least 6 chars";
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  key: confirmPasswordFieldKey,
                  hintText: "Confirm your password",
                  iconPath: "assets/images/ic_lock.svg",
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter confirm password";
                    if (value.length < 6)
                      return "Password must be at least 6 chars";
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                SizedBox(height: 30),

                authState.isLoading
                    ? const CircularProgressIndicator()
                    : GradientRoundedButton(
                        text: "Submit",
                        onPressed: () {
                          final nameValid = nameFieldKey.currentState!
                              .validate();
                          final emailValid = emailFieldKey.currentState!
                              .validate();
                          final passwordValid = passwordFieldKey.currentState!
                              .validate();
                          final confirmPasswordValid = confirmPasswordFieldKey
                              .currentState!
                              .validate();
                          if (nameValid &&
                              emailValid &&
                              passwordValid &&
                              confirmPasswordValid) {
                            getDeviceIdAndSignUp(ref);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const VerificationCode(),
                            //   ),
                            // );
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
