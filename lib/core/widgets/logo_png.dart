import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';

class LogoPng extends StatelessWidget {
  const LogoPng({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 8.h,
      ), // small vertical spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button - fixed size container so it won't grow

          // Logo - fixed size, fits inside its box
          SizedBox(
            width: 70.w,
            height: 40.h,
            child: Center(
                child: Image.asset(AppAssets.logopng)

              // ensure it scales correctly

            ),
          ),
        ],
      ),
    );
  }
}
