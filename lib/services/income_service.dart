import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeSerive {
  //Define a key for storing income in shared preferences
  static const String _incomeKey = "income";

  // Save the income in shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncome = pref.getStringList(_incomeKey);

      //converting existing income into income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncome != null) {
        existingIncomeObjects = existingIncome
            .map((e) => Income.fromJson(json.decode(e)))
            .toList();
      }

      existingIncomeObjects.add(income);
      //converting Income objects back to the list of income
      List<String> updatedIncomeList = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      pref.setStringList(_incomeKey, updatedIncomeList);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added successfully"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added successfully"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Method to load income from the shared preferences

  Future<List<Income>> loadIncome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncome = pref.getStringList(_incomeKey);

    List<Income> loadedIncome = [];

    if (existingIncome != null) {
      loadedIncome = existingIncome
          .map((e) => Income.fromJson(json.decode(e)))
          .toList();
    }
    return loadedIncome;
  }
}
