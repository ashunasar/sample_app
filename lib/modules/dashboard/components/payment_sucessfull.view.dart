import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/fonts.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';
import 'package:caard_frontend_final/presentation/views/home/home.view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class PaymentSucessView extends StatefulWidget {
  @override
  _PaymentSucessViewState createState() => _PaymentSucessViewState();
}

class _PaymentSucessViewState extends State<PaymentSucessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/payment_sucess.png"))),
            ),
            Text("Payment sucessful",
                style: KCustomTextstyle.kBold(context, 26)),
            vSizedBox3,
            // Text("Processing...Do not press back button or close the app",
            //     style: KCustomTextstyle.kMedium(context, 9)),
            // vSizedBox3,
            GestureDetector(
              onTap: () {
                pushNewScreen(context, screen: HomeView());
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: KConstantColors.darkColor),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Back to home",
                      style: TextStyle(
                          fontFamily: KConstantFonts.OpenSansBold,
                          fontSize: 10.sp,
                          color: KConstantColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
