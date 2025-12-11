import 'package:carebox/core/utils/app_colors.dart';
import 'package:carebox/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.suffixIcon,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,

      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '●',
      style: TextStyle(
        color: AppColors.primary,
        fontSize: 15.sp,
        fontWeight: AppFontsWeight.regular,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),

        errorStyle: TextStyle(
          color: AppColors.red,
          fontSize: 14.sp,
          fontWeight: AppFontsWeight.regular,
        ),

        filled: true,
        fillColor: AppColors.textAreaFill,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: AppFontsWeight.regular,
          fontSize: 15.sp,
          color: AppColors.textAreaFont,
        ),
        border: borderBuilder(),
        enabledBorder: borderBuilder(),
        focusedBorder: borderBuilder(color: AppColors.primary),
        focusedErrorBorder: borderBuilder(color: AppColors.primary),
        errorBorder: borderBuilder(color: AppColors.red),
      ),
    );
  }

  InputBorder borderBuilder({Color color = AppColors.textAreaBorder}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color),
      );
}
