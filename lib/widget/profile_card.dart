import 'package:expenz/constant/colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final IconData icon;
  const ProfileCard({
    super.key,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.6,
            color: kGrey.withValues(alpha: 0.2),
            spreadRadius: 0.4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: iconBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Icon(icon, size: 30, color: iconColor)),
              ),
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: kBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
