import 'package:allah_ho_allam_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final VoidCallback onAction;
  final String actionLabel;

  const MessageWidget({
    super.key,
    required this.message,
    required this.isError,
    required this.onAction,
    this.actionLabel = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    final color = isError ? AppColors.darkGreen : AppColors.green;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: color,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
