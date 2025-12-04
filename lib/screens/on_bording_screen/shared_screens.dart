import 'package:flutter/material.dart';

import 'package:expenz/constant/colors.dart';

class SharedScreens extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const SharedScreens({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 250, fit: BoxFit.cover),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: kBlack,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            description,
            style: TextStyle(
              color: kGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
