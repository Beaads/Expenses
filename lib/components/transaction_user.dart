import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transaction = [
    Transaction(
        id: 't1', title: 'Nova bolsa', value: 200.00, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Nova sandalia', value: 100.00, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionList(_transaction),
      TransactionForm(),
    ],
    );
  }
}
