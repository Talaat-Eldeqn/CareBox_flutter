import 'package:carebox/core/helper/my_navigator.dart';
import 'package:carebox/core/utils/app_assets.dart';
import 'package:carebox/core/utils/app_colors.dart';
import 'package:carebox/core/utils/app_paddings.dart';
import 'package:carebox/core/utils/app_text_styles.dart';
import 'package:carebox/core/widgets/custom_btn.dart';
import 'package:carebox/core/widgets/custom_text_btn.dart';
import 'package:carebox/core/widgets/custom_text_form_field.dart';
import 'package:carebox/core/widgets/svg_wrapper.dart';
import 'package:carebox/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:carebox/features/auth/cubit/login_cubit/login_state.dart';
import 'package:carebox/features/auth/views/forgot_password_view.dart';
import 'package:carebox/features/auth/views/register_view.dart';
import 'package:carebox/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/app_validator.dart';
import '../../../core/widgets/custom_unfilled_btn.dart';
import '../../../core/widgets/logo_png.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is LoginSuccess) {
            // Handle success (show message and navigate or replace)
            final msg = state.loginModel.message ?? "Logged in";
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
            // Replace with your app's home route or pop:
            MyNavigator.goTo(context, HomeView(), type: NavigatorType.push);
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
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
                        "Welcome back! Glad to see you, Again!",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: AppFontsWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // email
                      CustomTextFormField(
                        validator: AppValidator.validateEmail,
                        controller: cubit.email,
                        hintText: "Enter your email",
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
                        hintText: "Enter your password",
                      ),

                      SizedBox(height: 15.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextBtn(
                            text: "Forgot Password?",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 50.h),

                      state is LoginLoading
                          ? const CircularProgressIndicator()
                          : CustomBtn(
                              text: 'Login',
                              onPressed: () {
                                cubit.onLoginPressed();
                              },
                            ),

                      SizedBox(height: 20.h),

                      Row(
                        children: <Widget>[
                          Expanded(child: Divider()),
                          Text("Or Login With"),
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

                      SizedBox(height: 100.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account?'),
                          CustomTextBtn(
                            text: "Register Now",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterView(),
                                ),
                              );
                            },
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
