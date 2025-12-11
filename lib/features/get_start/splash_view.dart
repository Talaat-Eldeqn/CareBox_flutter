import 'package:carebox/core/helper/my_navigator.dart';
import 'package:carebox/core/utils/app_assets.dart';
import 'package:carebox/core/widgets/svg_wrapper.dart';
import 'package:carebox/features/get_start/onbourding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      MyNavigator.goTo(
        context,
        OnboardingView(),
        type: NavigatorType.pushAndRemoveUntil,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(AppAssets.logopng, height: 80.h, width: 80.w)],
      ),
    );
  }
}
