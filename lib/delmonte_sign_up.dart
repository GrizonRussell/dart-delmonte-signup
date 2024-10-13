// lib/delmonte_sign_up.dart
import 'package:flutter/material.dart';
import 'sign_up_stepper.dart';

class DelmonteSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: SignUpStepper(),
    );
  }
}
