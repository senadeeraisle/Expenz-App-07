import 'package:flutter/material.dart';

enum ExpenseCategory { shopping, subscriptions, food, health, transport }

final Map<ExpenseCategory, String> expenseCategoryImages = {
  ExpenseCategory.shopping: "assets/images/bag.png",
  ExpenseCategory.subscriptions: "assets/images/bill.png",
  ExpenseCategory.food: "assets/images/restaurant.png",
  ExpenseCategory.health: "assets/images/health.png",
  ExpenseCategory.transport: "assets/images/car.png",
};

final Map<ExpenseCategory, Color> expenseCategoryColor = {
  ExpenseCategory.shopping: const Color(0xFFFFD54F),
  ExpenseCategory.subscriptions: const Color(0xFF9575CD),
  ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.health: const Color(0xFF64B5F6),
  ExpenseCategory.transport: const Color(0xFF81C784),
};

class ExpenseModel {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final DateTime time;
  final ExpenseCategory category;
  final String description;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.time,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'category': category.index,
      'description': description,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      category: ExpenseCategory.values[json['category']],
      description: json['description'],
    );
  }
}
