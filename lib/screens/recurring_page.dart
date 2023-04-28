import 'package:flutter/material.dart';

class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (int i = 0; i < 5; i++)
        Column(
          children: [
            ListTile(
              leading: Text(
                "-100",
                style: TextStyle(
                  fontSize: 20, // Change the font size to 20
                  color: Colors.red, // Change the font color to red
                ),
              ),
              title: Text("Recurring Expense"),
              subtitle: Text("Interval"),
              trailing: Icon(Icons.sync),
              onLongPress: () {},
            ),
            Divider()
          ],
        )
    ]);
  }
}
