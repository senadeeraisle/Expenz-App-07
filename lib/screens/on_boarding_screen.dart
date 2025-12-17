import 'package:expenz/constant/colors.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/on_bording_screen/shared_screens.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:expenz/screens/on_bording_screen/front_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _controller = PageController();
  bool showHomePage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  showHomePage = index == 3;
                });
              },
              children: [
                FrontPage(),
                SharedScreens(
                  imagePath: OnboardingData.onBoardingPages[0].imagePath,
                  title: OnboardingData.onBoardingPages[0].title,
                  description: OnboardingData.onBoardingPages[0].description,
                ),
                SharedScreens(
                  imagePath: OnboardingData.onBoardingPages[1].imagePath,
                  title: OnboardingData.onBoardingPages[1].title,
                  description: OnboardingData.onBoardingPages[1].description,
                ),
                SharedScreens(
                  imagePath: OnboardingData.onBoardingPages[2].imagePath,
                  title: OnboardingData.onBoardingPages[2].title,
                  description: OnboardingData.onBoardingPages[2].description,
                ),
              ],
            ),
            Container(
              alignment: Alignment(0, 0.65),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: WormEffect(
                  activeDotColor: kMainColor,
                  dotColor: kLightGrey,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: !showHomePage
                  ? GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          _controller.page!.toInt() + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: CustomButton(
                        backgroundColor: kMainColor,
                        text: "Next",
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDataScreen(),
                          ),
                        );
                      },
                      child: CustomButton(
                        backgroundColor: kMainColor,
                        text: "Get Started",
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
