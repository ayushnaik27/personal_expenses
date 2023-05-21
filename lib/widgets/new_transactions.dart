import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.black)),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.black),
                ),
                controller: amountController,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}',
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          presentDatePicker();
                        },
                        icon: Icon(Icons.date_range))
                  ],
                ),
              ),
              TextButton(
                onPressed: () => submitData(),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
