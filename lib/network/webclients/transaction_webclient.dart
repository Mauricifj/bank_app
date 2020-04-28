import 'dart:convert';

import 'package:bankapp/models/transaction.dart';
import 'package:bankapp/network/webclient.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> transactions() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {
        "Content-type": "application/json",
        "password": "2000",
      },
      body: transactionJson,
    );

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
