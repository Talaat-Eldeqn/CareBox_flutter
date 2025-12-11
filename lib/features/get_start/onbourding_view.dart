import 'package:carebox/core/helper/my_navigator.dart';
import 'package:carebox/core/utils/app_assets.dart';
import 'package:carebox/core/utils/app_text_styles.dart';
import 'package:carebox/core/widgets/custom_btn.dart';
import 'package:carebox/features/auth/views/login_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _current = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AppAssets.washing,
      'title': 'Car Washing',
      'text':
          'Displays nearby car wash services and detailing centers, with booking options to simplify the process and enhance overall user experience.',
    },
    {
      'image': AppAssets.maintenance,
      'title': 'Maintenance Centers',
      'text':
          'Helps users locate suitable maintenance centers based on vehicle type and location. Supports booking and viewing available services.',
    },
    {
      'image': AppAssets.buying,
      'title': 'Buying & Selling Cars',
      'text':
          'Enables users to buy or sell vehicles and automotive items through a reliable marketplace, making the process easier and transparent.',
    },
    {
      'image': AppAssets.spareParts,
      'title': 'Spare Parts & Accessories',
      'text':
          'Offers access to genuine spare parts and accessories, with pricing and availability. Users can reserve items for pickup or delivery.',
    },
    {
      'image': AppAssets.emergency,
      'title': 'Emergency Services',
      'text':
          'Provides fast response to breakdowns with towing and roadside assistance. Real-time location tracking ensures safety during emergencies.',
    },
  ];

  void _goToLogin() {
    MyNavigator.goTo(
      context,
      const LoginView(),
      type: NavigatorType.pushAndRemoveUntil,
    );
  }

  void _next() {
    if (_current < pages.length - 1) {
      _pageController.animateToPage(
        _current + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _back() {
    if (_current > 0) {
      _pageController.animateToPage(
        _current - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            /// Skip Button (CustomBtn)

            /// PageView
            PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, i) {
                final page = pages[i];
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      child: Image.asset(page['image']!, fit: BoxFit.cover),
                    ),

                    /// Bottom white card (2/3 screen)
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24.r)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.w,
                            vertical: 26.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 69.h),
                              Text(
                                page['title']!,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: AppFontsWeight.bold,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              /// Scrollable description
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    page['text']!,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      height: 1.55,
                                      fontWeight: AppFontsWeight.regular,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.h),

                              SizedBox(height: 80.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Positioned(
              top: 20.h,
              left: 14.w,
              child: SizedBox(
                width: 80.w,
                child: TextButton(
                  onPressed: _goToLogin,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: AppFontsWeight.regular,
                      color: Color(0xFFA9A7A7),
                    ),
                  ),
                ),
              ),
            ),

            /// Bottom Controls
            Positioned(
              bottom: 18.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back (CustomBtn)
                  Opacity(
                    opacity: _current < 1 ? 0 : 1, // hides on slide 0 + 1
                    child: IgnorePointer(
                      ignoring: _current < 1,
                      child: SizedBox(
                        width: 90.w,
                        child: CustomBtn(text: "Back", onPressed: _back),
                      ),
                    ),
                  ),

                  /// Dots Indicator
                  DotsIndicator(
                    dotsCount: pages.length,
                    position: _current.toDouble(),
                    decorator: DotsDecorator(
                      size: Size(10.w, 10.h),
                      activeSize: Size(10.w, 10.h),
                      color: Colors.grey.shade400,
                      activeColor: Color(0xFF868686),
                    ),
                  ),

                  /// Next / Start (CustomBtn)
                  SizedBox(
                    width: 90.w,
                    child: CustomBtn(
                      text: _current == pages.length - 1 ? "Start" : "Next",

                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
