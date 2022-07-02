import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sample_app/utils/app_logger.dart';

import '../services/home_service.dart';

class HomeScreenController extends GetxController {
  final _homeService = HomeService();
  String message = 'Hello world!';

  @override
  void onReady() async {
    await getUserData();
    super.onReady();
  }

  void changeMessage() {
    message = 'GetX is awesome! ❤️';
    update();
  }

  Future<void> getUserData() async {
    try {
      await _homeService.userData();
    } catch (err) {
      AppLogger.printLog(err);
    }
  }
}
