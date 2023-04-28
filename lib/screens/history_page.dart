import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var _expenses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (int i = 0; i < _expenses.length; i++)
          Column(
            children: [
              ListTile(
                leading: Text(
                  "-10,00",
                  style: TextStyle(
                      fontSize: 20, // Change the font size to 20
                      color: Colors.red),
                ),
                title: Text('Expense ${_expenses[i]}'),
                subtitle: Text('2023-04-28'),
              ),
              Divider()
            ],
          )
      ],
    );
  }
}
