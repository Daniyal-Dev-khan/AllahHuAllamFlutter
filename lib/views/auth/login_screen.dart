import 'package:allah_ho_allam_flutter/views/auth/forgot_password.dart';
import 'package:allah_ho_allam_flutter/views/auth/sign_up_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_rounded_button.dart';
import '../../widgets/top_heading_and_description.dart';
import 'package:flutter/gestures.dart';
import '../viewModel/authViewModel.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final emailFieldKey = GlobalKey<CustomTextFieldState>();
  final passwordFieldKey = GlobalKey<CustomTextFieldState>();

  LoginScreen({super.key});

  Future<void> getFcmTokenAndLogin(WidgetRef ref) async {
    // Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    print("FCM Tokennnn: $fcmToken");
    print("FCM Tokennnn: $_emailController.text.trim()");

    // now you can send this fcmToken along with login API

    ref
        .read(authProvider.notifier)
        .login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          fcmToken!, // pass it here
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Shader gradientShader = const LinearGradient(
      colors: [
        AppColors.darkGreen, // dark green
        AppColors.green, // eucalyptus green
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (msg) {
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: Colors.green),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_primary.png"),
            // your background image
            fit: BoxFit.cover, // cover = fill entire screen
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            // wrap with SingleChildScrollView
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100), // space between texts

                TopHeadingAndDescription(
                  title: "Login",
                  decription: "Login to continue",
                ),

                SizedBox(height: 30), // space between texts

                CustomTextField(
                  key: emailFieldKey,
                  hintText: "Enter your email",
                  iconPath: "assets/images/ic_mail.svg",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter email";
                    final emailRegex = RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) return "Enter valid email";
                    return null;
                  },
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      ),
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w600, // Regular
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                authState.isLoading
                    ? const CircularProgressIndicator()
                    : GradientRoundedButton(
                        text: "Login",
                        onPressed: () {
                          final emailValid = emailFieldKey.currentState!
                              .validate();
                          final passwordValid = passwordFieldKey.currentState!
                              .validate();
                          if (emailValid && passwordValid) {
                            // Example usage of provider
                            getFcmTokenAndLogin(ref);
                          }
                        },
                      ),

                const SizedBox(height: 20),
                Text(
                  "or",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500, // Bold
                  ),
                ),

                const SizedBox(height: 30),

                RichText(
                  text: TextSpan(
                    text: "Don’t have an account? ",
                    style: const TextStyle(
                      color: Colors.black, // color for normal text
                      fontFamily: 'Satoshi',
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = gradientShader,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
