import 'package:flutter/material.dart';
import 'package:emu/services/sqlite_service.dart';
import 'package:intl/intl.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({
    super.key,
  });

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Future<List<Expense>> _expenses;
  int sumThisYear = 0;
  int sumThisMonth = 0;

  NumberFormat _numberFormat = NumberFormat.decimalPattern("de_AT");

  @override
  void initState() {
    super.initState();
    _expenses = SqliteService().getItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculateSums();
  }

  void calculateSums() async {
    final expenses = await _expenses;
    final now = DateTime.now();
    for (final expense in expenses) {
      if (DateTime.parse(expense.date).year == now.year) {
        sumThisYear += expense.amount;
      }
      if (DateTime.parse(expense.date).year == now.year &&
          DateTime.parse(expense.date).month == now.month) {
        sumThisMonth += expense.amount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Expense>>(
        future: _expenses,
        builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(
                child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  "Your expenses",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: ListTile(
                      title: Text(
                        _numberFormat.format(sumThisYear),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        "This year",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: InkWell(
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: ListTile(
                      title: Text(
                        _numberFormat.format(sumThisMonth),
                        style: TextStyle(
                          fontSize: 20, // Change the font size to 20
                          color: Colors.red, // Change the font color to red
                        ),
                      ),
                      subtitle: Text("This month"),
                    ),
                  ),
                ),
              ],
            ));
          } else {
            return Center(child: Text('No expenses found.'));
          }
        });
  }
}
