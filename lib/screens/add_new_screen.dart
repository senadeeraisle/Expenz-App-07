import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widget/custom_button.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  int _selectedMethod = 0;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  ExpenseCategory _expenseCategory = ExpenseCategory.shopping;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 0 ? kRed : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 1 ? kGreen : kWhite,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 60,
                            ),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How Much?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: kWhite,
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: kWhite,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: kWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: 10,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                          initialValue: _selectedMethod == 0
                              ? _incomeCategory
                              : _expenseCategory,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          items: _selectedMethod == 0
                              ? IncomeCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList()
                              : ExpenseCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMethod == 0
                                  ? _incomeCategory = value as IncomeCategory
                                  : _expenseCategory = value as ExpenseCategory;
                            });
                          },
                        ),
                        const SizedBox(height: kDefaultPadding),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            hintText: "Amount",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2027),
                                ).then((value) {
                                  setState(() {
                                    if (value != null) {
                                      _selectedDate = value;
                                    }
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kMainColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 30,
                                        color: kWhite,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kYellow,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        size: 30,
                                        color: kWhite,
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(_selectedTime),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: kLightGrey, thickness: 5),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: "Add",
                          backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
