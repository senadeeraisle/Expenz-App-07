import 'package:expenz/constant/colors.dart';
import 'package:expenz/screens/on_boarding_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_details_service.dart';
import 'package:expenz/widget/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String email = "";

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(10),
          color: kLightGrey,
          height: 200,
          width: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Log out?",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Are you sure to log out",
                  style: TextStyle(
                    color: kGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          kMainColor,
                        ),
                      ),
                      onPressed: () async {
                        await UserService.deleteUserDetails();
                        if (context.mounted == true) {
                          await ExpenseService().deleteAllExpenses(context);
                          await IncomeSerive().deleteAllIncome(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BoardingScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kWhite,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          kMainColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    UserService.getUserData().then((value) {
      if (value["name"] != null && value["email"] != null) {
        setState(() {
          userName = value["name"]!;
          email = value["email"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: kMainColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        child: Image.asset(
                          "assets/images/user.jpg",
                          fit: BoxFit.fill,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: kGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kGrey.withValues(alpha: 0.2),
                      ),
                      child: Icon(Icons.edit, size: 30, color: kBlack),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ProfileCard(
                  iconColor: kMainColor,
                  iconBackgroundColor: kMainColor.withValues(alpha: 0.2),
                  title: 'Wallet',
                  icon: Icons.wallet,
                ),
                ProfileCard(
                  iconColor: kMainColor,
                  iconBackgroundColor: kMainColor.withValues(alpha: 0.2),
                  title: 'Settings',
                  icon: Icons.settings,
                ),
                ProfileCard(
                  iconColor: kMainColor,
                  iconBackgroundColor: kMainColor.withValues(alpha: 0.2),
                  title: 'Export Data',
                  icon: Icons.download,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    iconColor: kRed,
                    iconBackgroundColor: kRed.withValues(alpha: 0.2),
                    title: 'Log Out',
                    icon: Icons.logout,
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
