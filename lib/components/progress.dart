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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Text(message)
        ],
      ),
    );
  }
}
