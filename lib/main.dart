import 'package:flutter/material.dart';
import 'package:third_app/widgets/chart.dart';
import 'package:third_app/widgets/new_transaction.dart';
import 'package:third_app/widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

const locale = "it_IT";
DateFormat timeFormat;
DateFormat dayFormat;
DateFormat transactionDateFormat;

//void main() => runApp(MyApp(),);
void main() {
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //consento solo la modalità verticale
  ]);*/
  runApp(MyApp(),);
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //parsing into it locale
    initializeDateFormatting(locale).then((_) {
      timeFormat = DateFormat.E(locale);
      dayFormat = DateFormat.yMMMd(locale);
      transactionDateFormat = DateFormat.yMd(locale);
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple, //primary swatch generate different tonality of color auitomatically
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            fontFamily: 'QuickSand',
          ),
          title: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          )
        ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
    /*Transaction(
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
    ),*/
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {

    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      //with add i modify the list inside final _userTransaction, not the pointer to object
      //it is allowed with final
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransaction, transactionDateFormat);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) =>  tx.id == id );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions, timeFormat),
              ),
              Container(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: TransactionList(_userTransaction, _deleteTransaction, dayFormat)
              ),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
