import 'package:bankapp/models/transaction.dart';
import 'package:bankapp/screens/transaction/form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Transactions";

class TransactionSummary extends StatefulWidget {
  final List<Transaction> _transactions = List();

  @override
  State<StatefulWidget> createState() {
    return TransactionSummaryState();
  }
}

class TransactionSummaryState extends State<TransactionSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
      body: ListView.builder(
        itemCount: widget._transactions.length,
        itemBuilder: (context, index) {
          final transaction = widget._transactions[index];
          return TransactionItem(transaction);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransactionForm();
          })).then((transaction) => _add(transaction));
        },
      ),
    );
  }

  void _add(Transaction transaction) {
    if (transaction != null) {
      setState(() {
        widget._transactions.add(transaction);
      });
    }
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction _transaction;

  TransactionItem(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transaction.amount.toString()),
        subtitle: Text(_transaction.accountNumber),
      ),
    );
  }
}
