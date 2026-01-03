import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonSvg extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const BackButtonSvg({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
        width: 40, // adjust as you want
        height: 40,
      ),
    );
  }
}
