class Transaction {
  final String accountNumber;
  final double amount;

  Transaction(
    this.accountNumber,
    this.amount,
  );

  @override
  String toString() =>
      'Transaction{accountNumber: $accountNumber, amount: $amount}';
}
