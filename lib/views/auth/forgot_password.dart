import 'package:flutter/material.dart';

import '../../widgets/back_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_rounded_button.dart';
import '../../widgets/top_heading_and_description.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final emailFieldKey = GlobalKey<CustomTextFieldState>();

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
                  title: "Forgot Password",
                  decription:
                      "Enter your email, we will send you verification code via email",
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
                SizedBox(height: 30),
                GradientRoundedButton(
                  text: "Submit",
                  onPressed: () {
                    final emailValid = emailFieldKey.currentState!.validate();
                    if (emailValid) {}
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
