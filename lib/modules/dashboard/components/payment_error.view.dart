import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';
import 'package:sizer/sizer.dart';

class PaymentErrorView extends StatefulWidget {
  @override
  _PaymentErrorViewState createState() => _PaymentErrorViewState();
}

class _PaymentErrorViewState extends State<PaymentErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [KConstantColors.bgColor, KConstantColors.darkColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Images/payment_error.png"))),
            ),
            Text("Something went wrong",
                style: KCustomTextstyle.kBold(context, 22)),
            Text("Please book service again.",
                style: KCustomTextstyle.kBold(context, 12)),
            vSizedBox3,
          ],
        ),
      ),
    );
  }
}
