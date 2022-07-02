import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../controller/splash_controller.dart';

class SplashScreenView extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
                child: Assets.images.appIcon.image(width: width * 0.6)),
            SizedBox(height: 2.0.h),
            const Text("CAARD™"),
            SizedBox(height: 2.0.h),
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.black),
            )
          ],
        )),
      ),
    );
  }
}
