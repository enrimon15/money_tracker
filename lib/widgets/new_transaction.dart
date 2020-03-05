import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  //String titleInput;
  //String amountInput;
  //class provided by flutter to assign at textfield to take user input
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function addTx;
  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                /*onChanged: (val) {
                        titleInput = val;
                      },*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                //onChanged: (val) => titleInput = val,
              ),
              FlatButton(
                child: Text('Add Transaction'),
                textColor: Colors.purple,
                onPressed: () {
                  //call addNewTransaction
                  this.addTx(titleController.text, double.parse(amountController.text));
                },
              )
            ],
          ),
        )
    );
  }
}
