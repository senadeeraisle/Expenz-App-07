import 'package:flutter/material.dart';

enum IncomeCategory { salary, freelance, passiveIncome, sales }

final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.salary: "assets/images/salary.png",
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.passiveIncome: "assets/images/car.png",
  IncomeCategory.sales: "assets/images/health.png",
};

final Map<IncomeCategory, Color> incomeCategoryColors = {
  IncomeCategory.salary: const Color.fromARGB(255, 188, 170, 112),
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

  // convert expense object into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      category: IncomeCategory.values[json['category']],
      description: json['description'],
    );
  }
}
