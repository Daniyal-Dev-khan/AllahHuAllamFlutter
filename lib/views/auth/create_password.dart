import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_rounded_button.dart';
import '../../widgets/top_heading_and_description.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final passwordFieldKey = GlobalKey<CustomTextFieldState>();
    final confirmPasswordFieldKey = GlobalKey<CustomTextFieldState>();

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
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                SizedBox(height: 100), // space between texts
                TopHeadingAndDescription(
                  title: "Create Password",
                  decription: "Please fill the required fields",
                ),
                SizedBox(height: 30), // space between texts
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
                GradientRoundedButton(text: "Submit", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
