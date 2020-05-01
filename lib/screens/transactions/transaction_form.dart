import 'package:bankapp/components/progress.dart';
import 'package:bankapp/components/response_dialog.dart';
import 'package:bankapp/components/transaction_auth_dialog.dart';
import 'package:bankapp/models/contact.dart';
import 'package:bankapp/models/transaction.dart';
import 'package:bankapp/network/webclients/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _appBarTitle = 'New transfer';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  State<StatefulWidget> createState() {
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.contact.name,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      widget.contact.account.toString(),
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextField(
                      readOnly: _sending,
                      controller: _valueController,
                      style: TextStyle(fontSize: 24.0),
                      decoration: InputDecoration(labelText: 'Value'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        child: Text('Transfer'),
                        onPressed: () {
                          if (!_sending) {
                            final double value =
                                double.tryParse(_valueController.text);
                            final transactionCreated = Transaction(
                                transactionId, value, widget.contact);
                            showDialog(
                                context: context,
                                builder: (contextDialog) {
                                  return TransactionAuthDialog(
                                    onConfirm: (String password) {
                                      _save(transactionCreated, password,
                                          context);
                                    },
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Loading(message: "Sending..."),
              visible: _sending,
            ),
          ],
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );
    _showSuccessMessage(transaction, context);
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return transaction;
  }

  void _showSuccessMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Successful transaction");
          });
      Navigator.pop(context);
    }
  }

  void _showFailureMessage(
    BuildContext context, {
    String message = 'There was an error.\nPlease, try again later.',
  }) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
