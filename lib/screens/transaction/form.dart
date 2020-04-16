import 'package:bankapp/components/padding_text_field.dart';
import 'package:bankapp/models/transaction.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'New transaction';

const _labelAccountNumber = "Account Number";
const _hintAccountNumber = "0000";

const _labelAmount = "Amount";
const _hintAmount = "0.00";

const _buttonText = "Confirm";

class TransactionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionFormState();
  }
}

class TransactionFormState extends State<TransactionForm> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PaddingTextField(
                controller: _accountNumberController,
                label: _labelAccountNumber,
                hint: _hintAccountNumber),
            PaddingTextField(
                controller: _amountController,
                label: _labelAmount,
                hint: _hintAmount,
                icon: Icons.monetization_on),
            RaisedButton(
              child: Text(_buttonText),
              onPressed: () => _newTransaction(context),
            ),
          ],
        ),
      ),
    );
  }

  void _newTransaction(BuildContext context) {
    final String accountNumber = _accountNumberController.text;
    final double amount = double.tryParse(_amountController.text);

    if (accountNumber != null && amount != null) {
      final transaction = Transaction(accountNumber, amount);
      Navigator.pop(context, transaction);
    }
  }
}
