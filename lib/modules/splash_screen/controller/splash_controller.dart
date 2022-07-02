import 'dart:async';

import 'package:get/get.dart';
import 'package:sample_app/controllers/global/global_controller.dart';
import 'package:sample_app/utils/app_logger.dart';
import 'package:sample_app/utils/preference.dart';

import '../../../shared/models/user.dart';

class SplashController extends GetxController {
  GlobalController globalController = Get.find<GlobalController>();
  @override
  onInit() {
    Timer(const Duration(seconds: 2), initiateCache);
    super.onInit();
  }

  Future initiateCache() async {
    bool isUserLoggedIn = Preference.getBool('IsLoggedIn') ?? false;

    if (isUserLoggedIn) {
      String? email = Preference.getString('Email');
      String? userId = Preference.getString('UserId');
      String? userName = Preference.getString('UserName');
      String? imgUrl = Preference.getString('ImgUrl');
      String? fullName = Preference.getString('FullName');
      globalController.currentUser = User(
          userName: userName!,
          email: email!,
          userId: userId!,
          imgUrl: imgUrl,
          fullName: fullName);
      AppLogger.printLog(globalController.currentUser!.toJson().toString());
      // Navigator.pushReplacementNamed(context, AppRouter.HomeRoute);

    } else {
      // Navigator.pushReplacementNamed(context, AppRouter.OnBoardRoute);
    }
  }
}
