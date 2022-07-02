import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:caard_frontend_final/presentation/views/dashboard/components/product_description.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:caard_frontend_final/app/shared/colors.dart';
import 'package:caard_frontend_final/app/shared/textstyles.dart';

class ViewAllProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Widget _productItem() {
    //   return GestureDetector(
    //     onTap: () {
    //       pushNewScreen(context, screen: ProductDescriptionView());
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(),
    //       child: Row(
    //         children: [
    //           Container(
    //               height: 10.h,
    //               width: 20.w,
    //               decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                       image: AssetImage("assets/images/p3.png")))),
    //           hSizedBox2,
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text("Porsche 1526",
    //                   style: KCustomTextstyle.kBold(context, 12)),
    //               Text("Cards", style: KCustomTextstyle.kBold(context, 10)),
    //               Text("Lorem Ipsum is simply dummy",
    //                   style: KCustomTextstyle.kMedium(context, 8))
    //             ],
    //           ),
    //           Spacer(),
    //           Text("\$160.99", style: KCustomTextstyle.kBold(context, 10)),
    //           hSizedBox1
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(),
                  CaarProducts()
                  // Container(
                  //   height: 87.h,
                  //   child: ListView.builder(
                  //     physics: BouncingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: 10,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return _productItem();
                  //     },
                  //   ),
                  // ),
                ],
              ),
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
        Text("All Products", style: KCustomTextstyle.kBold(context, 12)),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.moreHorizontalOutline,
                color: KConstantColors.conditionalColor(context: context)))
      ],
    );
  }
}

class CaarProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _products = [
      {"image": "assets/images/p1.png", "price": 100, "title": "Porsche 1526"},
      {"image": "assets/images/p2.png", "price": 100, "title": "BMW QT67"},
      {"image": "assets/images/p3.png", "price": 100, "title": "Audi M71"},
      {"image": "assets/images/p1.png", "price": 100, "title": "Audi M71"},
      {"image": "assets/images/p2.png", "price": 100, "title": "Audi M71"},
      {"image": "assets/images/p3.png", "price": 100, "title": "Audi M71"},
      {"image": "assets/images/p2.png", "price": 100, "title": "Audi M71"},
      {"image": "assets/images/p1.png", "price": 100, "title": "Audi M71"},
    ];

    _productBlock(
        {required String image, required String title, required int price}) {
      return GestureDetector(
        onTap: () {
          pushNewScreen(context, screen: ProductDescriptionView());
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(image)))),
              Text(title, style: KCustomTextstyle.kBold(context, 10)),
              Text("\$${price.toString()}",
                  style: KCustomTextstyle.kBold(context, 8)),
            ],
          ),
        ),
      );
    }

    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _productBlock(
                  title: _products[index]['title'],
                  price: _products[index]['price'],
                  image: _products[index]['image']));
        },
      ),
    );
  }
}
