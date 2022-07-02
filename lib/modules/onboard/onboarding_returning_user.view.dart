import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/widgets/custom_buttons.dart';
import '../../utils/dimensions.dart';

class OnboardingReturningUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/s1.png")),
                            borderRadius: BorderRadius.circular(16))),
                    vSizedBox3,
                    vSizedBox2,
                    Text(
                      "All your online profiles \nat one place",
                      textAlign: TextAlign.center,
                      // style: KCustomTextstyle.kBold(context, 14),
                    ),
                    vSizedBox3,
                    CustomButtons.roundedCorner(
                        title: "Sign up",
                        width: 90,
                        height: 6,
                        onTap: () {
                          // Navigator.of(context)
                          //     .pushReplacementNamed(AppRouter.SignUpRoute);
                        },
                        // textStyle: KCustomTextstyle.kBoldWhite(context, 12),
                        context: context,
                        // backgroundColor: KConstantColors.darkColor,
                        cornerRadius: 25.0),
                    vSizedBox2,
                    CustomButtons.roundedCorner(
                        height: 6,
                        width: 90,
                        title: "Login",
                        onTap: () {
                          // Navigator.of(context)
                          //     .pushReplacementNamed(AppRouter.LoginRoute);
                        },
                        // textStyle: KCustomTextstyle.kBold(context, 12),
                        context: context,
                        // backgroundColor: KConstantColors.texturedWhiteColor,
                        cornerRadius: 25.0)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
