import 'package:bankapp/components/centered_message.dart';
import 'package:bankapp/components/progress.dart';
import 'package:bankapp/models/transaction.dart';
import 'package:bankapp/network/webclients/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Transactions";

class TransactionList extends StatefulWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
      body: FutureBuilder(
        future: widget._webClient.transactions(),
        builder: (context, snapshot) {
          final List<Transaction> transactions = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return CenteredMessage("Unknown error");
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return TransactionItem(transactions[index]);
                    },
                  );
                } else {
                  return CenteredMessage("No transactions found",
                      icon: Icons.block);
                }
              }
              return CenteredMessage(
                "Error to retrieve transactions",
                icon: Icons.warning,
              );
              break;
          }
          return CenteredMessage("Unknown error");
        },
      ),
    );
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
        title: Text(_transaction.value.toString()),
        subtitle: Text(
            "${_transaction.contact.name} (${_transaction.contact.account})"),
      ),
    );
  }
}
