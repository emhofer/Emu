import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Emu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    OverviewPage(),
    RecurringPage(),
    HistoryPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emu")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                if (_currentIndex != 1) {
                  return SingleExpenseForm();
                } else {
                  return RecurringExpenseForm();
                }
              },
            );
          },
          child: const Icon(Icons.add)),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
          child: _pages.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Recurring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({
    super.key,
  });

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
            },
            child: ListTile(
              title: Text(
                "-5 632,78",
                style: TextStyle(
                  fontSize: 20, // Change the font size to 20
                  color: Colors.red, // Change the font color to red
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
                "-964,13",
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

class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

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
              SizedBox(
                height: 10,
              ),
              Divider()
            ],
          )
      ],
    );
  }
}
