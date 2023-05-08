import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 469,
      child: transactions.isEmpty
          ? Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/exclamation.png',
                      height: 50,
                    ),
                    Text('No entries yet'),
                  ]),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(

                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            '₹${transactions[index].amount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title),
                    subtitle: Text(DateFormat()
                        .add_yMMMd()
                        .format(transactions[index].date)),
                    trailing: IconButton(onPressed: () => deleteTx(transactions[index].id), icon: Icon(Icons.delete),color: Theme.of(context).errorColor),
                  ),
                );
              },
            ),
    );
  }
}
