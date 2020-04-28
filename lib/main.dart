import 'package:bankapp/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(BankApp());

class BankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Dashboard(),
    );
  }
}
