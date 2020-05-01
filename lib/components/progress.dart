import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  Loading({this.message = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
