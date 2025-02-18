import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat.yMd().format(_selectedDate)
                        , style: TextStyle(
                        color: Colors.grey
                      ),
                      ),
                    ),
                    TextButton(onPressed: _presentDatePicker, child: Text('Choose Date', style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => _submitData,
                  child: Text('Add Transaction'))
            ],
          ),
        ),
      ),
    );
  }


}