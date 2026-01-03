import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TopHeadingAndDescription extends StatefulWidget {
  final String title;
  final String decription;

  const TopHeadingAndDescription({
    super.key,
    required this.title,
    required this.decription,
  });

  @override
  State<TopHeadingAndDescription> createState() =>
      _TopHeadingAndDescriptionState();
}

class _TopHeadingAndDescriptionState extends State<TopHeadingAndDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 24,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w700, // Bold
          ),
        ),
        SizedBox(height: 10), // space between texts
        // 🧩 Description
        Text(
          widget.decription,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
