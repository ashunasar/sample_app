import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/fonts.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';
import 'package:caard_frontend_final/presentation/views/dashboard/components/shopping_cart.view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class ProductDescriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              CustomAppBar(),
              vSizedBox2,
              Text("Porsche 1526", style: KCustomTextstyle.kBold(context, 22)),
              vSizedBox1,
              Container(
                height: 30.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/p3.png")))),
                    Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/p2.png")))),
                    Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/p1.png")))),
                  ],
                ),
              ),
              Text("\$160.99", style: KCustomTextstyle.kBold(context, 20)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.star, color: KConstantColors.yellowColor),
                Icon(Icons.star, color: KConstantColors.yellowColor),
                Icon(Icons.star, color: KConstantColors.yellowColor),
                Icon(Icons.star, color: KConstantColors.yellowColor),
                hSizedBox1,
                Text("10 Reviews", style: KCustomTextstyle.kMedium(context, 10))
              ]),
              vSizedBox3,
              GestureDetector(
                onTap: () {
                  pushNewScreen(context, screen: ShoppingCartView());
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
                        "Buy Now",
                        style: TextStyle(
                            fontFamily: KConstantFonts.OpenSansBold,
                            fontSize: 10.sp,
                            color: KConstantColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              ),
              vSizedBox2,
              GestureDetector(
                onTap: () {
                  pushNewScreen(context, screen: ShoppingCartView());
                },
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: KConstantColors.textColor),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                            fontFamily: KConstantFonts.OpenSansBold,
                            fontSize: 10.sp,
                            color: KConstantColors.darkColor),
                      ),
                    ),
                  ),
                ),
              ),
              vSizedBox3,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.center,
                  style: KCustomTextstyle.kMedium(context, 10),
                ),
              )
            ],
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
        Text("Collection details", style: KCustomTextstyle.kBold(context, 12)),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.moreHorizontalOutline,
                color: KConstantColors.conditionalColor(context: context)))
      ],
    );
  }
}
