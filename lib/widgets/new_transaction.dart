import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  //class provided by flutter to assign at textfield to take user input
  final Function addTx;
  final DateFormat transactionDateFormat;
  NewTransaction(this.addTx, this.transactionDateFormat);

  @override
  _NewTransactionState createState() => _NewTransactionState(transactionDateFormat);
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  final DateFormat _transactionDateFormat;
  
  _NewTransactionState(this._transactionDateFormat);

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    this.widget.addTx( //this.widget call main class that create the state
        enteredTitle,
        enteredAmount,
        _selectedDate,
    );

    Navigator.of(context).pop(); //context is a property available in state class //to close modal
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2019), 
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                //viewinsets is what is load in uor view. in this case viewInsets.bottom is how much space is taken by a keyboard
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  //with onSubmitted i make possible also to add transaction with enter key
                  onSubmitted: (_) => this._submitData(), // (_) it means that i pass a value to function (current text) but it is not used
                  /*onChanged: (val) {
                          titleInput = val;
                  },*/
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => this._submitData( ),
                  //onChanged: (val) => titleInput = val,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          _selectedDate == null
                              ? 'No date chosen'
                              : 'Date: ${_transactionDateFormat.format(_selectedDate)}'
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      onPressed: this._presentDatePicker,
                    )
                  ],
                ),
                RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: this._submitData,
                )
              ],
            ),
          )
      ),
    );
  }
}
