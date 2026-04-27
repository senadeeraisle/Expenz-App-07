import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryChart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  final bool isexpense;
  const CategoryChart({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isexpense,
  });

  @override
  State<CategoryChart> createState() => _CategoryChartState();
}

class _CategoryChartState extends State<CategoryChart> {
  List<PieChartSectionData> sectionData() {
    if (widget.isexpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.food] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.health],
          value: widget.expenseCategoryTotal[ExpenseCategory.health] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.shopping] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.subscriptions],
          value:
              widget.expenseCategoryTotal[ExpenseCategory.subscriptions] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.transport] ?? 0,
          radius: 60,
          showTitle: false,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.freelance] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passiveIncome],
          value: widget.incomeCategoryTotal[IncomeCategory.passiveIncome] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotal[IncomeCategory.salary] ?? 0,
          radius: 60,
          showTitle: false,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategoryTotal[IncomeCategory.sales] ?? 0,
          radius: 60,
          showTitle: false,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sections: sectionData(),
      startDegreeOffset: -90,
      sectionsSpace: 0,
      centerSpaceRadius: 60,
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: kWhite,
      ),
      padding: EdgeInsets.all(kDefaultPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(children: [Text("")]),
        ],
      ),
    );
  }
}
