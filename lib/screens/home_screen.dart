import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constants.dart';
import 'package:expenz/services/user_details_service.dart';
import 'package:expenz/widget/reusable/income_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";

  @override
  void initState() {
    UserService.getUserData().then((value) {
      if (value["name"] != null) {
        setState(() {
          userName = value["name"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: kMainColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kGrey,
                            border: Border.all(color: kMainColor, width: 3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100),
                            child: Image.asset(
                              "assets/images/user.jpg",
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Welcome $userName",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kBlack,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: kMainColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeCard(
                            bgColor: kGreen,
                            title: 'Income',
                            amount: 8000,
                            imagePath: 'assets/images/income.png',
                          ),
                          IncomeCard(
                            bgColor: kRed,
                            title: 'Expense',
                            amount: 8000,
                            imagePath: 'assets/images/expense.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
