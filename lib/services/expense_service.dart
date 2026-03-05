import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //Expense List
  List<Expense> expenseList = [];

  //Define a key for storing expenses in shared preferences

  static const String expenseKey = 'expense';

  // Save the expenses in shared preferences
  Future<void> saveExpense(Expense expense, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpense = pref.getStringList(expenseKey);

      //converting existing expense into expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpense != null) {
        existingExpenseObjects = existingExpense
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }
      existingExpenseObjects.add(expense);

      // Convert Expense object list back to th list of stings
      List<String> updatedExpenseList = existingExpenseObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      await pref.setStringList(expenseKey, updatedExpenseList);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding the expense"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Load expense from shared preferences

  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpense = pref.getStringList(expenseKey);

    List<Expense> loadedExpenses = [];
    if (existingExpense != null) {
      loadedExpenses = existingExpense
          .map((e) => Expense.fromJson(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }

  // method to delete expense from sheard preferences

  Future<void> deleteExpense(id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpense = pref.getStringList(expenseKey);
      List<Expense> exsistingExpenseObject = [];
      if (existingExpense != null) {
        exsistingExpenseObject = existingExpense
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }
      exsistingExpenseObject.removeWhere((expense) => expense == id);

      List<String> updatedExpenseList = exsistingExpenseObject
          .map((e) => json.encode(e.toJson()))
          .toList();

      await pref.setStringList(expenseKey, updatedExpenseList);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The expense deleted successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The expense is not deleted successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
