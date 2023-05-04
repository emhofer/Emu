import 'package:emu/services/sqlite_service.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Expense>> _expenses;

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
                        '-${expense.amount.toString()}',
                        style: TextStyle(
                            fontSize: 20, // Change the font size to 20
                            color: Colors.red),
                      ),
                      title: Text(expense.description),
                      subtitle: Text(expense.date),
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
