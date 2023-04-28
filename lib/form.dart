import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _dateController) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        _dateController = TextEditingController(text: formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Expense Amount',
                      border: OutlineInputBorder(),
                    ))),
            Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        labelText: 'Name', border: OutlineInputBorder()))),
            Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                child: TextFormField(
                  controller: _dateController,
                  textAlign: TextAlign.center,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Date', border: OutlineInputBorder()),
                  onTap: () async {
                    _selectDate(context);
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: () {}, child: Text("Submit")),
            )
          ],
        )));
  }
}
