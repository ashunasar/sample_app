// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constant_colors.dart';
import '../../../utils/dimensions.dart';
import '../models/sk_onboarding_model.dart';

class SKOnboardingScreen extends StatefulWidget {
  final List<SkOnboardingModel> pages;
  final Color bgColor;
  final Color themeColor;
  final ValueChanged<String> skipClicked;
  final ValueChanged<String> getStartedClicked;

  SKOnboardingScreen({
    required this.pages,
    required this.bgColor,
    required this.themeColor,
    required this.skipClicked,
    required this.getStartedClicked,
  });

  @override
  SKOnboardingScreenState createState() => SKOnboardingScreenState();
}

class SKOnboardingScreenState extends State<SKOnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  List<Widget> buildOnboardingPages() {
    final children = <Widget>[];

    for (int i = 0; i < widget.pages.length; i++) {
      children.add(_showPageData(widget.pages[i]));
    }
    return children;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? widget.themeColor : KConstantColors.textColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.bgColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 600.0,
                      color: Colors.transparent,
                      child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: buildOnboardingPages()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    // _currentPage != widget.pages.length - 1
                    //     ? Expanded(
                    //         child: Align(
                    //           alignment: FractionalOffset.bottomRight,
                    //           child: Padding(
                    //             padding: EdgeInsets.only(right: 20, bottom: 10),
                    //             child: FloatingActionButton(
                    //               backgroundColor: widget.bgColor,
                    //               child: Icon(
                    //                 Icons.arrow_forward,
                    //                 color: widget.themeColor,
                    //               ),
                    //               onPressed: () {
                    //                 _pageController.nextPage(
                    //                   duration: Duration(milliseconds: 500),
                    //                   curve: Curves.ease,
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: _currentPage == widget.pages.length - 1
            ? _showGetStartedButton()
            : _showGetStartedButton());
  }

  Widget _showPageData(SkOnboardingModel page) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 400, child: Image(image: AssetImage(page.imagePath))),
          vSizedBox2,
          Text(
            page.title,
            textAlign: TextAlign.center,
            // style: KCustomTextstyle.kBold(context, 16)
          ),
          vSizedBox1,
          Text(
            page.description,
            textAlign: TextAlign.center,
            // style: KCustomTextstyle.kMedium(context, 10)
          ),
        ],
      ),
    );
  }

  Widget _showGetStartedButton() {
    final GestureDetector loginButtonWithGesture = GestureDetector(
      onTap: _getStartedTapped,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            color: widget.themeColor,
            borderRadius: BorderRadius.all(Radius.circular(26.0))),
        child: const Center(
          child: Text(
            'Get Started',
            // style: KCustomTextstyle.kBoldWhite(context, 12),
          ),
        ),
      ),
    );

    return Padding(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0),
        child: loginButtonWithGesture);
  }

  void _getStartedTapped() {
    widget.getStartedClicked("Get Started Tapped");
  }
}
