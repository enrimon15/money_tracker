import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:third_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final DateFormat dayFormat;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx, this.dayFormat);

  //there are two way to use ListView.
  //with children (bad performance with long list --> it render all the object inside the list and make it scrollable)
  //with builder constructor (more efficient --> lazy load --> it render only the object visible on the screen and load dynamically the other object)

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
           return  Column(
                      children: <Widget>[
                        Text(
                          'No transactions added yet!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .title,
                        ),
                        SizedBox(height: 30,), //this is a separator box
                        Container(
                            height: constraints.maxHeight * 0.6,
                            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
                        ),
                      ],
                    );
        })
        : ListView.builder(
          //listview builder render/load only the row visible
          //ListView is a widget that take an infinity height and not the available height like a Column. It don't take a definite height
            itemBuilder: (ctx, index) {
              return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('${transactions[index].amount}€',)
                        ),
                      ),
                    ),
                    title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      dayFormat.format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme
                            .of(context)
                            .errorColor,
                      ),
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
              );

        /*return Card(
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  //2 decimal number. with asFixed it automatically rounded
                  '\$ ${this.transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor, //i pass theme data in context and take them of constructor
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                    /*TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),*/
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(this.transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        );*/
      },
      itemCount: this.transactions.length, //flutter know that have to call item builder length time
    );
  }
}
