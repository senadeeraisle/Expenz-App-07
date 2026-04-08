import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_details_service.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:expenz/widget/reusable/total_card.dart';
import 'package:expenz/widget/spend_line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    UserService.getUserData().then((value) {
      if (value["name"] != null) {
        setState(() {
          userName = value["name"]!;
        });
      }
    });

    for (var i = 0; i < widget.expenseList.length; i++) {
      expenseTotal += widget.expenseList[i].amount;
    }

    for (var e = 0; e < widget.incomeList.length; e++) {
      incomeTotal += widget.incomeList[e].amount;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TotalCard(
                            bgColor: kGreen,
                            title: 'Income',
                            amount: incomeTotal,
                            imagePath: 'assets/images/income.png',
                          ),
                          TotalCard(
                            bgColor: kRed,
                            title: 'Expense',
                            amount: expenseTotal,
                            imagePath: 'assets/images/expense.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spend Frequency",
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  // line chart
                  SpendLineChart(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transaction",
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  widget.expenseList.isEmpty
                      ? Text(
                          "Please add some expenses to display here",
                          style: TextStyle(
                            color: kGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.expenseList.length,
                          itemBuilder: (context, index) {
                            final expense = widget.expenseList[index];
                            return ExpenseCard(
                              title: expense.title,
                              amount: expense.amount,
                              date: expense.date,
                              time: expense.time,
                              category: expense.category,
                              description: expense.description,
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
