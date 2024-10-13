import 'package:flutter/material.dart';

class SubscribeToEmail extends StatefulWidget {
  @override
  _SubscribeToEmailState createState() => _SubscribeToEmailState();
}

class _SubscribeToEmailState extends State<SubscribeToEmail> {
  bool isChecked = false;

  void handleCheckboxChange(bool? value) {
    if (value != null) {
      setState(() {
        isChecked = value;
        storeData("isSubscribeToEmail", isChecked ? 1 : 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0E4028), // Background color
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: handleCheckboxChange,
            activeColor: Colors.white,
            checkColor: const Color(0xFF0E4028), // Checkbox check color
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Agree (optional)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void storeData(String key, int value) {
    // Implement your local storage logic here
  }
}
