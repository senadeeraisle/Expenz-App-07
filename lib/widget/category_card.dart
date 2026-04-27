import 'package:expenz/constant/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double totalAmount;
  final Color categoryColor;
  final bool isExpense;
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.totalAmount,
    required this.categoryColor,
    required this.isExpense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressBarWidth = widget.amount != 0
        ? MediaQuery.of(context).size.width *
              (widget.amount / widget.totalAmount)
        : 0;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kWhite,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: kGrey.withValues(alpha: 0.2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kBlack.withValues(alpha: 0.05),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: widget.categoryColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(widget.title),
                  ],
                ),
              ),
              Text(
                "-\$${widget.amount}",
                style: TextStyle(
                  color: kRed,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            height: 10,
            width: progressBarWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.categoryColor,
            ),
          ),
        ],
      ),
    );
  }
}
