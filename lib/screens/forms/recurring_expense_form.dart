import 'package:flutter/material.dart';

class RecurringExpenseForm extends StatefulWidget {
  const RecurringExpenseForm({super.key});

  @override
  State<RecurringExpenseForm> createState() => _RecurringExpenseFormState();
}

class _RecurringExpenseFormState extends State<RecurringExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('New recurring expense'),
      content: Text("Hello, world!"),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Save the form data and close the dialog
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
    ;
  }
}
