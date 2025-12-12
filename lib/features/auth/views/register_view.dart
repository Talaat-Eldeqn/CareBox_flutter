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
import 'package:carebox/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:carebox/features/auth/cubit/register_cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/app_validator.dart';
import '../../../core/widgets/logo_png.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.msg)));
            // Navigate back to login after successful registration
            MyNavigator.goBack(context);
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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

                      // full name
                      CustomTextFormField(
                        validator: AppValidator.validateUsername,
                        controller: cubit.fullName,
                        hintText: "Full name",
                      ),
                      SizedBox(height: 15.h),

                      // email
                      CustomTextFormField(
                        validator: AppValidator.validateEmail,
                        controller: cubit.email,
                        hintText: "Email",
                      ),
                      SizedBox(height: 15.h),

                      // password
                      CustomTextFormField(
                        validator: AppValidator.validatePassword,
                        controller: cubit.password,
                        suffixIcon: IconButton(
                          onPressed: cubit.changePasswordSecure,
                          icon: SvgWrapper(svgPath: AppAssets.eye),
                        ),
                        obscureText: cubit.passwordSecure,
                        hintText: "Password",
                      ),
                      SizedBox(height: 15.h),

                      // confirm password
                      CustomTextFormField(
                        validator: (String? value) {
                          return AppValidator.validateConfirmPassword(
                            value,
                            cubit.password.text,
                          );
                        },
                        controller: cubit.confirmPassword,
                        suffixIcon: IconButton(
                          onPressed: cubit.changeConfirmPasswordSecure,
                          icon: SvgWrapper(svgPath: AppAssets.eye),
                        ),
                        obscureText: cubit.confirmPasswordSecure,
                        hintText: "Confirm Password",
                      ),

                      SizedBox(height: 15.h),

                      // phone number (optional)
                      CustomTextFormField(
                        validator: AppValidator.validatePhoneNumber,
                        controller: cubit.phoneNumber,
                        hintText: "Phone Number",
                      ),

                      SizedBox(height: 38.h),

                      // Register button: show loading state if needed
                      state is RegisterLoading
                          ? const CircularProgressIndicator()
                          : CustomBtn(
                              text: 'Register',
                              onPressed: () {
                                cubit.onRegisterPressed();
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
