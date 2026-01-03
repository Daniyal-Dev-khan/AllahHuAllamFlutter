import 'package:flutter/material.dart';

import '../utils/colors.dart';

class GradientRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkGreen, // dark green (startColor)
              AppColors.green, // eucalyptus green (endColor)
            ],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.background,
              fontSize: 18,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
