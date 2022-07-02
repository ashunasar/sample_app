import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/fonts.dart';
import 'package:caard_frontend_final/presentation/views/dashboard/components/add_new_address.view.dart';
import 'package:caard_frontend_final/presentation/views/dashboard/components/payment_sucessfull.view.dart';
import 'package:caard_frontend_final/presentation/widgets/custom_loader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';

class DeliveryAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _oldAddress() {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Confirm your CAAR order?",
                      style: KCustomTextstyle.kBold(context, 10)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No",
                          style: KCustomTextstyle.kMedium(context, 10)),
                    ),
                    MaterialButton(
                        color: KConstantColors.darkColor,
                        child: Text("Yes",
                            style: TextStyle(
                                fontFamily: KConstantFonts.OpenSansBold,
                                fontSize: 10.sp,
                                color: KConstantColors.whiteColor)),
                        onPressed: () {
                          pushNewScreen(context,
                              screen: CustomScreenLoader(
                                  duration: 5,
                                  title: "Proceding Payment",
                                  toScreen: PaymentSucessView()));
                        })
                  ],
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.mapPin),
              hSizedBox2,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("West indravati park, Pune",
                      style: KCustomTextstyle.kBold(context, 10)),
                  Text("HOME", style: KCustomTextstyle.kMedium(context, 10)),
                ],
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 16)),
              hSizedBox1
            ],
          ),
        ),
      );
    }

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                CustomAppBar(),
                vSizedBox2,
                GestureDetector(
                  onTap: () {
                    pushNewScreen(context, screen: AddNewAddressView());
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    child: Center(
                        child: Text("Add new address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: KConstantFonts.OpenSansBold,
                                fontSize: 10.sp,
                                color: KConstantColors.whiteColor))),
                    decoration: BoxDecoration(
                        color: KConstantColors.bgColor,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                vSizedBox2,
                Container(
                  height: 70.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return _oldAddress();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close,
                color: KConstantColors.conditionalColor(context: context))),
        Text("Select address", style: KCustomTextstyle.kBold(context, 12)),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.moreHorizontalOutline,
                color: KConstantColors.conditionalColor(context: context)))
      ],
    );
  }
}
