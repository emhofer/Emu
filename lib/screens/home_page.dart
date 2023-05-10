import 'package:flutter/material.dart';
import '../services/sqlite_service.dart';

import 'overview_page.dart';
import 'recurring_page.dart';
import 'history_page.dart';
import 'settings_page.dart';

import './forms/single_expense_form.dart';
import './forms/recurring_expense_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Expense>> _expensesFuture; // Future to fetch expenses
  late List<Widget> _pages; // Pages list

  @override
  void initState() {
    super.initState();
    _expensesFuture = SqliteService().getItems();
  }

  void updateExpenses() {
    setState(() {
      // Perform logic to update the expenses
      // For example, you might refetch the expenses from SQLite
      _expensesFuture = SqliteService().getItems();
    });
  }

  int _currentIndex = 0;
  bool _showFAB = true;

  final List<String> _pageTitles = [
    "Emu",
    "Recurring Expenses",
    "History",
    "Settings",
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 3) {
      _showFAB = false;
    } else {
      _showFAB = true;
    }
    return FutureBuilder<List<Expense>>(
        future: _expensesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the expenses, show a loading indicator or any other widget
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error case if necessary
            return Text('Error loading expenses');
          } else {
            final expenses = snapshot.data;
            _pages = [
              OverviewPage(expenses: expenses ?? []),
              RecurringPage(),
              HistoryPage(
                expenses: expenses ?? [],
                updateExpenseList: updateExpenses,
              ),
              SettingsPage(),
            ];
            return Scaffold(
              appBar: AppBar(title: Text(_pageTitles[_currentIndex])),
              floatingActionButton: _showFAB
                  ? FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            if (_currentIndex != 1) {
                              return SingleExpenseForm(
                                updateExpenseList: updateExpenses,
                              );
                            } else {
                              return const RecurringExpenseForm();
                            }
                          },
                        );
                      },
                      child: const Icon(Icons.add))
                  : null,
              body: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                  child: _pages.elementAt(_currentIndex)),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: onTabTapped,
                items: [
                  const BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: const Icon(Icons.sync),
                    label: 'Recurring',
                  ),
                  const BottomNavigationBarItem(
                    icon: const Icon(Icons.history),
                    label: 'History',
                  ),
                  const BottomNavigationBarItem(
                    icon: const Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            );
          }
        });
  }
}
