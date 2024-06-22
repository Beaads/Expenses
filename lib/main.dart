import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transaction = [
    Transaction(
        id: 't1',
        title: 'Nova bolsa',
        value: 200.00,
        date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        id: 't2',
        title: 'Nova sandalia',
        value: 100.00,
        date: DateTime.now().subtract(const Duration(days: 4))),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: [
        if(isLandscape)
        IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart)
        ),
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: isLandscape ? const Icon(Icons.add) : Container()),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // if (isLandscape)
              //   Row(
              //     children: [
              //       const Text('Exibir Grafico'),
              //       Switch.adaptive(
              //           value: true,
              //           onChanged: (value) {
              //             setState(() {
              //               _showChart = value;
              //             });
              //           })
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                SizedBox(
                    height: availableHeight * (isLandscape ? 0.8 : 0.30),
                    child: Chart(recentTransaction: _recentTransaction)),
              if (!_showChart || !isLandscape)
                SizedBox(
                    height: availableHeight * (isLandscape ? 1 : 0.70),
                    child: TransactionList(_transaction, _removeTransaction)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
