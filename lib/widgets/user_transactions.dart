import 'package:flutter/material.dart';
import 'package:third_app/models/transaction.dart';
import 'package:third_app/widgets/transaction_list.dart';

import 'new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _userTransaction = [
    Transaction(
      id: '1',
      title: 'Cinema',
      amount: 17.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Food',
      amount: 21.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction), //passo il puntatore della funzione
        TransactionList(_userTransaction),
      ],
    );
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString(),
    );

     setState(() {
       //with add i modify the list inside final _userTransaction, not the pointer to object
       //it is allowed
       _userTransaction.add(newTx);
     });
  }
}
