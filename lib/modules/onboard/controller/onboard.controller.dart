import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/constant_colors.dart';
import '../models/sk_onboarding_model.dart';

class OnboardingController extends GetxController {
  final pages = [
    SkOnboardingModel(
        title: 'All your online profiles \nat one place',
        description:
            'Grow your network and and make it seamlessly\n to get in touch with you',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/splash.png'),
    SkOnboardingModel(
        title: 'Explore our unique products',
        description:
            'Digital Business Cards, \n Mobile Tags, Wrist Bands and much more...',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/s2.png'),
    SkOnboardingModel(
        title: 'Socialize with people within boundaries',
        description:
            'Diversified ways of connecting to \npeople or customers you want to get in touch with',
        titleColor: KConstantColors.bgColorFaint,
        descripColor: KConstantColors.darkColor,
        imagePath: 'assets/images/s3.png'),
    SkOnboardingModel(
        title: 'Choose various themes',
        description: 'You can get access to multiple themes for your profile',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/s4.png'),
  ];
}
