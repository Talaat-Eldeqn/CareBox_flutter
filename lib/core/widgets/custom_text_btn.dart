import 'package:carebox/core/utils/app_colors.dart';
import 'package:carebox/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: AppFontsWeight.bold,
          color: AppColors.textButtonPrimary,
        ),
      ),
    );
  }
}
