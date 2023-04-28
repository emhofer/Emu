import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleExpenseForm extends StatefulWidget {
  @override
  _SingleExpenseFormState createState() => _SingleExpenseFormState();
}

class _SingleExpenseFormState extends State<SingleExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  int? _amount = 0;
  String _text = "";
  TextEditingController _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

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
    return AlertDialog(
      scrollable: true,
      title: const Text('New expense'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _amount = null;
                  }
                  _amount = int.tryParse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a text';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () async {
                _selectDate(context);
              },
            )
          ],
        ),
      ),
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
  }
}
