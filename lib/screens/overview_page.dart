import 'package:flutter/material.dart';

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
