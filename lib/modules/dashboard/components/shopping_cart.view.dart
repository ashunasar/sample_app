import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:caard_frontend_final/app/shared/dimensions.dart';
import 'package:caard_frontend_final/app/shared/fonts.dart';
import 'package:caard_frontend_final/presentation/views/dashboard/components/delivery_address.view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';

class ShoppingCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _productItem() {
      return GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Container(
                  height: 10.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/p3.png")))),
              hSizedBox2,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Porsche 1526",
                      style: KCustomTextstyle.kBold(context, 12)),
                  Text("\$160.99", style: KCustomTextstyle.kBold(context, 10)),
                  Text("Lorem Ipsum is simply dummy",
                      style: KCustomTextstyle.kMedium(context, 8))
                ],
              ),
              Spacer(),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          size: 16,
                        )),
                    Text("1", style: KCustomTextstyle.kBold(context, 10)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove,
                          size: 16,
                        )),
                  ],
                ),
              ),
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
                Container(
                  height: 70.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return _productItem();
                    },
                  ),
                ),
                Divider(
                  color: KConstantColors.darkColor,
                ),
                Text(
                  "Subtotal : \$1330.99",
                  style: KCustomTextstyle.kBold(context, 16),
                ),
                vSizedBox2,
                GestureDetector(
                  onTap: () {
                    pushNewScreen(context,
                        screen: DeliveryAddressView(), withNavBar: false);
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    child: Center(
                        child: Text("Pay Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: KConstantFonts.OpenSansBold,
                                fontSize: 10.sp,
                                color: KConstantColors.whiteColor))),
                    decoration: BoxDecoration(
                        color: KConstantColors.bgColor,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                )
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
        Text("My Cart", style: KCustomTextstyle.kBold(context, 12)),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.moreHorizontalOutline,
                color: KConstantColors.conditionalColor(context: context)))
      ],
    );
  }
}
