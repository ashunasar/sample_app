import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';

class OrderConfirmationView extends StatefulWidget {
  @override
  _OrderConfirmationViewState createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
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
            Text("Confirm your CAAR order",
                style: KCustomTextstyle.kBold(context, 22)),
            Text("Are you sure want to order physical CAAR QR sticker?",
                style: KCustomTextstyle.kBold(context, 22)),
            Text("Will be delivered at ",
                style: KCustomTextstyle.kBold(context, 12)),
            vSizedBox3,
          ],
        ),
      ),
    );
  }
}
