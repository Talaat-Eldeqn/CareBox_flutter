import 'package:carebox/core/helper/my_navigator.dart';
import 'package:carebox/core/utils/app_assets.dart';
import 'package:carebox/core/utils/app_colors.dart';
import 'package:carebox/core/utils/app_paddings.dart';
import 'package:carebox/core/utils/app_text_styles.dart';
import 'package:carebox/core/widgets/custom_btn.dart';
import 'package:carebox/core/widgets/custom_text_btn.dart';
import 'package:carebox/core/widgets/custom_text_form_field.dart';
import 'package:carebox/core/widgets/custom_unfilled_btn.dart';
import 'package:carebox/core/widgets/svg_wrapper.dart';
import 'package:carebox/features/auth/cubit/register_cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/app_validator.dart';
import '../../../core/widgets/logo_png.dart';
import '../cubit/register_cubit/register_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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

                      Text(
                        "Hello! Register to get started",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: AppFontsWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomTextFormField(
                        validator: AppValidator.validateUsername,
                        controller: cubit.userNameController,
                        hintText: "Username",
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        validator: AppValidator.validateEmail,
                        controller: cubit.emailController,
                        hintText: "Email",
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        validator: AppValidator.validatePassword,
                        controller: cubit.passwordController,
                        suffixIcon: IconButton(
                          onPressed: cubit.changePasswordVisibility,
                          icon: SvgWrapper(svgPath: AppAssets.eye),
                        ),

                        // hide when true
                        obscureText: cubit.passwordSecure,
                        hintText: "Password",
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        validator: (String? value) {
                          return AppValidator.validateConfirmPassword(
                            value,
                            cubit.passwordController.text,
                          );
                        },
                        controller: cubit.passwordConfirmController,
                        suffixIcon: IconButton(
                          onPressed: cubit.changePasswordConfirmVisibility,
                          icon: SvgWrapper(svgPath: AppAssets.eye),
                        ),
                        // hide when true
                        obscureText: cubit.passwordSecure,
                        hintText: "Confirm Password",
                      ),

                      SizedBox(height: 38.h),

                      CustomBtn(
                        text: 'Register',
                        onPressed: () {
                          cubit.formKey.currentState!.validate();
                        },
                      ),

                      SizedBox(height: 20.h),

                      Row(
                        children: <Widget>[
                          Expanded(child: Divider()),

                          Text("Or Register With"),

                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: 22.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomUnfilledBtn(
                            image: AppAssets.facebookIcon,
                            onPressed: () {},
                          ),
                          CustomUnfilledBtn(
                            image: AppAssets.googleIcon,
                            onPressed: () {},
                          ),
                          CustomUnfilledBtn(
                            image: AppAssets.appleIcon,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      SizedBox(height: 40.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?'),

                          CustomTextBtn(
                            text: "Login Now",
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
