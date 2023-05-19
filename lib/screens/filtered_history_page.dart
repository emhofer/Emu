import 'package:emu/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilteredHistoryPage extends StatefulWidget {
  final List<Expense> expenses;
  final String filter;
  // final Function() updateExpenseList;

  const FilteredHistoryPage(
      {super.key, required this.expenses, required this.filter
      // required this.updateExpenseList,
      });

  @override
  State<FilteredHistoryPage> createState() => _FilteredHistoryPageState();
}

class _FilteredHistoryPageState extends State<FilteredHistoryPage> {
  NumberFormat _numberFormat = NumberFormat("#,##0.00", "de_AT");
  var _testExpenses;

  @override
  void initState() {
    super.initState();
    // _expenses = SqliteService().getItems();
    _testExpenses = widget.expenses.where((element) {
      if (widget.filter == "year") {
        return element.date.substring(0, 4) ==
            DateTime.now().toString().substring(0, 4);
      } else if (widget.filter == "month") {
        return element.date.substring(5, 7) ==
            DateTime.now().toString().substring(5, 7);
      } else {
        return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          for (Expense expense in _testExpenses)
            Column(
              children: [
                ListTile(
                  leading: Text(
                    '-${_numberFormat.format(expense.amount)}',
                    style: const TextStyle(
                        fontSize: 20, // Change the font size to 20
                        color: Colors.red),
                  ),
                  title: Text(expense.description),
                  subtitle: Text(expense.date),
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete expense?"),
                            content: const Text(
                                "Are you sure you want to delete this expense?"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    debugPrint(expense.toString());
                                    SqliteService().deleteItem(expense.id);
                                    // widget.updateExpenseList();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete"))
                            ],
                          );
                        });
                  },
                ),
                Divider()
              ],
            )
        ],
      ),
    );
  }
}
