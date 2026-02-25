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
import 'package:flutter/material.dart';

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
    List<Expense> loadExpense = await ExpenseService().loadedExpenses();

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

  //Function to add new income

  void addNewIncome(Income newIncome) {
    IncomeSerive().saveIncome(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(),
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
