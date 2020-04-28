import 'package:bankapp/screens/contacts/contact_list.dart';
import 'package:bankapp/screens/transactions//transaction_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/piggy.jpg"),
          ),
          Container(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _MenuItem(
                  "Transfer",
                  Icons.monetization_on,
                  onClick: () => _showContactList(context),
                ),
                _MenuItem(
                  "Transaction Feed",
                  Icons.description,
                  onClick: () => _showTransferHistory(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _showContactList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ContactList()));
}

void _showTransferHistory(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TransactionList()));
}

class _MenuItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _MenuItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).buttonColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, size: 24.0),
                Text(name, style: TextStyle(fontSize: 16.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
