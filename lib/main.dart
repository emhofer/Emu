import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
                child: Column(
              children: [
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text("-100"),
                        subtitle: Text("This year"),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text("-15"),
                        subtitle: Text("This month"),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Form(
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
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 10),
                        child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder()))),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Submit")),
                    )
                  ],
                )),
                Spacer()
              ],
            )),
          )),
        ));
  }
}
