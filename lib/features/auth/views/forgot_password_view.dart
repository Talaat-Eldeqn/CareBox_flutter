import 'package:carebox/core/helper/my_navigator.dart';
import 'package:carebox/core/utils/app_assets.dart';
import 'package:carebox/core/widgets/custom_btn.dart';
import 'package:carebox/core/widgets/custom_text_btn.dart';
import 'package:carebox/core/widgets/custom_unfilled_btn.dart';
import 'package:carebox/core/widgets/logo_png.dart';
import 'package:carebox/core/widgets/svg_wrapper.dart';
import 'package:carebox/features/auth/cubit/login_cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/app_validator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_paddings.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../cubit/login_cubit/forgot_password_cubit.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgotPasswordCubit(),
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          var cubit = ForgotPasswordCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: AppPaddings.defaultPadding,
                  child: Column(
                    children: [
                      SafeArea(child: LogoPng()),
                      SizedBox(height: 35.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Password?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: AppFontsWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Don't worry! It occurs. Please enter the email address linked with your account.",

                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: AppFontsWeight.medium,
                              color: AppColors.textAreaFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 37.h),
                      CustomTextFormField(
                        validator: AppValidator.validateEmail,
                        controller: cubit.emailController,
                        hintText: "    Enter your email",
                      ),

                      SizedBox(height: 50.h),

                      CustomBtn(
                        text: "Send Code",
                        onPressed: () {
                          cubit.onSendCodePressed();
                        },
                      ),
                      SizedBox(height: 340.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Remember Password?'),

                          CustomTextBtn(
                            text: "Login",
                            onPressed: () => MyNavigator.goBack(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
