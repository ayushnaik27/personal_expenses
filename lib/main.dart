import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './models/transactions.dart';
import './widgets/new_transactions.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        errorColor: Colors.grey,
        fontFamily: 'OpenSans',
        textTheme: Typography.whiteRedwoodCity,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<transaction> _userTransactions = [
    // transaction(
    //   id: 'AX08RRT',
    //   title: 'New Shirts',
    //   amount: 299.54,
    //   date: DateTime.now(),
    // ),
    // transaction(
    //   id: 'PX08ZUT',
    //   title: 'New Shoes',
    //   amount: 1546.79,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showchart = false;

  List<transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // final titleController = TextEditingController();
    // final amountController = TextEditingController();

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text(
        'Personal Expenses App',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
          tooltip: 'Add Transaction',
        )
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.6,
        child: TransactionList(_userTransactions, deleteTransaction));

    final chartWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.8,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Chart(_recentTransactions));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/sky.jpg'), fit: BoxFit.cover),
      
            // gradient: LinearGradient(
            //   colors: [Colors.purple.shade200, Colors.orange.shade300],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (isLandscape)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Show Chart'),
                        Switch(
                            value: _showchart,
                            onChanged: (val) {
                              setState(() {
                                _showchart = val;
                              });
                            }),
                      ],
                    ),
                    _showchart ? chartWidget : txListWidget
                  ],
                ),
              if (!isLandscape)
                Column(
                  children: [
                    Container(
                        height: (mediaQuery.size.height -
                                appbar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.3,
                        child: Chart(_recentTransactions)),
                    txListWidget,
                  ],
                )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Transaction',
      ),
    );
  }
}
