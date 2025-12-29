import 'package:flutter/material.dart';

enum IncomeCategory { salary, freelance, passiveIncome, sales }

final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.salary: "assets/images/salary.png",
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.passiveIncome: "assets/images/car.png",
  IncomeCategory.sales: "assets/images/health.png",
};

final Map<IncomeCategory, Color> incomeCategoryColors = {
  IncomeCategory.salary: const Color(0xFFFFD54F),
  IncomeCategory.freelance: const Color(0xFFE57373),
  IncomeCategory.passiveIncome: const Color(0xFF81C784),
  IncomeCategory.sales: const Color(0xFF64B5F6),
};

class IncomeModel {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}
