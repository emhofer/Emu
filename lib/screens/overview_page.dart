import 'package:flutter/material.dart';
import 'package:emu/services/sqlite_service.dart';
import 'package:intl/intl.dart';
import './filtered_history_page.dart';

class OverviewPage extends StatefulWidget {
  final List<Expense> expenses;
  const OverviewPage({
    super.key,
    required this.expenses,
  });

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  // late Future<List<Expense>> _expenses;
  double sumThisYear = 0;
  double sumThisMonth = 0;

  NumberFormat _numberFormat = NumberFormat("#,##0.00", "de_AT");

  @override
  void initState() {
    super.initState();
    // _expenses = SqliteService().getItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    calculateSums();
  }

  void calculateSums() async {
    // final expenses = await _expenses;
    final now = DateTime.now();
    for (final expense in widget.expenses) {
      if (DateTime.parse(expense.date).year == now.year) {
        sumThisYear += expense.amount;
      }
      if (DateTime.parse(expense.date).year == now.year &&
          DateTime.parse(expense.date).month == now.month) {
        sumThisMonth += expense.amount;
      }
    }
  }

  void navigateToFilteredHistoryPage(DateTime filter) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FilteredHistoryPage(
                expenses: widget.expenses,
                filter: filter,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              navigateToFilteredHistoryPage(DateTime.now());
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
  }
}
