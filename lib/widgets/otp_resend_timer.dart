import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class OtpResendTimer extends StatefulWidget {
  final VoidCallback onResend;

  const OtpResendTimer({super.key, required this.onResend});

  @override
  State<OtpResendTimer> createState() => _OtpResendTimerState();
}

class _OtpResendTimerState extends State<OtpResendTimer> {
  static const int _resendAfter = 30; // seconds
  late Stream<int> _timerStream;
  late StreamController<int> _controller;
  int _remaining = _resendAfter;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
    _startTimer();
  }

  void _startTimer() {
    _remaining = _resendAfter;
    _timerStream = Stream.periodic(
      const Duration(seconds: 1),
      (x) => x,
    ).take(_resendAfter).map((count) => _resendAfter - count - 1);
    _controller.addStream(_timerStream);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        final remaining = snapshot.data ?? _remaining;

        if (remaining > 0) {
          return Text(
            "Resend code in ${remaining}s",
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              widget.onResend();
              _startTimer();
            },
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.darkGreen, AppColors.green],
              ).createShader(bounds),
              child: const Text(
                "Resend Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // ignored by ShaderMask
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
