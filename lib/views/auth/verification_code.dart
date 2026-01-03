import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/colors.dart';
import '../../widgets/back_button.dart';
import '../../widgets/gradient_rounded_button.dart';
import '../../widgets/otp_resend_timer.dart';
import '../../widgets/top_heading_and_description.dart';
import 'package:pinput/pinput.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textPrimary.withValues(alpha: 0.2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(width: 2, color: Colors.green.shade600),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.green.withOpacity(0.1),
      ),
    );

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
                  title: "OTP Code",
                  decription: "The confirmation code was sent via email",
                ),
                SizedBox(height: 30),
                Text(
                  "daniyal.dev@gmail.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w700, // Bold
                  ),
                ),

                SizedBox(height: 30),
                // 🔢 OTP PIN VIEW
                Pinput(
                  length: 4,
                  controller: _otpController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  defaultPinTheme: defaultPinTheme,

                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onCompleted: (pin) {
                    print("Entered OTP: $pin");
                  },
                ),

                SizedBox(height: 30),

                OtpResendTimer(
                  onResend: () {
                    // re-send OTP logic here
                    // print("Resending OTP...");
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
