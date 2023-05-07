import 'package:emu/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Expense>> _expenses;

  NumberFormat _numberFormat = NumberFormat.decimalPattern("de_AT");

  @override
  void initState() {
    super.initState();
    _expenses = SqliteService().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Expense>>(
      future: _expenses,
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return ListView(
            children: <Widget>[
              for (Expense expense in snapshot.data!)
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
          );
        } else {
          return Center(child: Text('No expenses found.'));
        }
      },
    );
  }
}
