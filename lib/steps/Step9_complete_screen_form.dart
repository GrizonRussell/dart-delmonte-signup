import 'package:flutter/material.dart';

class StepsCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Text(
            'Yey',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8), // Space between the text and checkbox
          Checkbox(
            value: false, // Set initial checkbox value
            onChanged: (bool? value) {
              // Handle checkbox state change
            },
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
