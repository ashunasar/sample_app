import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/internet_connection_checker.dart';
import '../controllers/home_screen.controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (HomeScreenController controller) {
          return InternetConnectionChecker(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xffE9EDF1),
                body: SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.message,
                          style: const TextStyle(color: Colors.black)),
                      ElevatedButton(
                          onPressed: () {
                            controller.changeMessage();
                          },
                          child: const Text('Change Message'))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
