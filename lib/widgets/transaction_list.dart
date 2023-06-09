import 'package:flutter/material.dart';

import '../models/transactions.dart';
import './transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:500,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/exclam.png',
                        height: constraints.maxHeight * 0.2,
                        fit: BoxFit.scaleDown,

                      ),
                      Text('No entries yet'),
                    ]),
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return transactionListItem(
                    transaction: transactions[index], deleteTx: deleteTx);
              },
            ),
    );
  }
}
