import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.iconPath,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  void _onChanged(String value) {
    if (errorText != null) {
      setState(() => errorText = null); // 🧹 remove error while typing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(25),
            // border: errorText != null
            //     ? Border.all(color: Colors.redAccent, width: 1)
            //     : null,
          ),
          child: Row(
            children: [
              SvgPicture.asset(widget.iconPath, height: 22, width: 22),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword,
                  onChanged: _onChanged,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: AppColors.textPrimary),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
      ],
    );
  }

  /// Call this from parent when validating form
  bool validate() {
    final text = widget.controller.text;
    final error = widget.validator?.call(text);
    setState(() => errorText = error);
    return error == null;
  }
}
