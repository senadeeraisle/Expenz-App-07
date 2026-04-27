import 'package:flutter/material.dart';

import 'package:expenz/constant/colors.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchExpenses;
      fetchIncome;
    });
  }

  //fetch expenses list
  void fetchExpenses() async {
    List<Expense> loadExpense = await ExpenseService().loadExpenses();

    setState(() {
      expenseList = loadExpense;
    });
  }

  // fetch income list
  void fetchIncome() async {
    List<Income> loadIncome = await IncomeSerive().loadIncome();
    setState(() {
      incomeList = loadIncome;
    });
  }

  //Function to add new expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpense(newExpense, context);
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //Function to delete expense

  void deleteExpense(Expense expense) {
    ExpenseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }
  //Function to delete an income

  void deleteIncome(Income income) {
    IncomeSerive().deleteIncome(income.id, context);
    incomeList.remove(income);
  }
  //Function to add new income

  void addNewIncome(Income newIncome) {
    IncomeSerive().saveIncome(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  Map<ExpenseCategory, double> calculateExpenseCategoryTotal() {
    Map<ExpenseCategory, double> expenseCategoryTotal = {
      ExpenseCategory.food: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.subscriptions: 0,
      ExpenseCategory.transport: 0,
    };

    for (Expense expense in expenseList) {
      expenseCategoryTotal[expense.category] =
          expenseCategoryTotal[expense.category]! + expense.amount;
    }
    return expenseCategoryTotal;
  }

  Map<IncomeCategory, double> calculateIncomeCategory() {
    Map<IncomeCategory, double> incomeCategoryTotal = {
      IncomeCategory.freelance: 0,
      IncomeCategory.passiveIncome: 0,
      IncomeCategory.salary: 0,
      IncomeCategory.sales: 0,
    };

    for (Income income in incomeList) {
      incomeCategoryTotal[income.category] =
          incomeCategoryTotal[income.category]! + income.amount;
    }

    return incomeCategoryTotal;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BudgetScreen(
        incomeCategoryTotal: calculateIncomeCategory(),
        expenseCategoryTotal: calculateExpenseCategoryTotal(),
      ),
      HomeScreen(expenseList: expenseList, incomeList: incomeList),
      TransactionScreen(
        onDismissedIncome: deleteIncome,
        incomeList: incomeList,
        expenseList: expenseList,
        onDismissedExpenses: deleteExpense,
      ),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMainColor,
              ),
              child: Center(child: Icon(Icons.add, color: kWhite)),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: "Budget",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }
}
