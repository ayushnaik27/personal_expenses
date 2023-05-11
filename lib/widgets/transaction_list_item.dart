import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class transactionListItem extends StatelessWidget {
  const transactionListItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0.2,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                '₹${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(DateFormat().add_yMMMd().format(transaction.date)),
        trailing: IconButton(
            onPressed: () => deleteTx(
                  transaction.id,
                ),
            tooltip: 'delete',
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor),
      ),
    );
  }
}
