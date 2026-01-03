import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F9D58), Color(0xFF34A853)],
          ),
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator(strokeWidth: 4, color: Colors.white),
        ),
      ),
    );
  }
}
