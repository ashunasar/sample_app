import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/pages.routes.dart';
import '../../utils/constant_colors.dart';
import 'controller/onboard.controller.dart';
import 'widgets/sk_onboarding_screen.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SKOnboardingScreen(
          bgColor: KConstantColors.whiteColor,
          themeColor: KConstantColors.bgColorFaint,
          pages: controller.pages,
          skipClicked: (value) {},
          getStartedClicked: (value) {
            Get.offNamed(Routes.onBoardReturningUserRoute);
          },
        ),
      ),
    );
  }
}
