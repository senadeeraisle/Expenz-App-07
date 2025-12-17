import 'package:expenz/constant/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", width: 130, fit: BoxFit.cover),
        SizedBox(height: 15),
        Text(
          "Expenz",
          style: TextStyle(
            color: kMainColor,
            fontWeight: FontWeight.w700,
            fontSize: 50,
          ),
        ),
      ],
    );
  }
}
