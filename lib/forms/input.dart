import 'package:flutter/material.dart';
import 'package:sink/utils/validations.dart';
import 'package:sink/exceptions/InvalidInput.dart';

class ExpenseForm extends StatefulWidget {

  @override
  ExpenseFormState createState() {
    return ExpenseFormState();
  }
}

class ExpenseFormState extends State<ExpenseForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _description;
  double _cost;
  String _category;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Enter a price"),
              keyboardType: TextInputType.number,
              autofocus: true,
              validator: (value) => _validatePrice(value),
              onSaved: (value) => _cost = double.parse(value),
            ),
            _textFormField("Add a note", (value) => _description = value),
            _textFormField("Enter a category", (value) => value = _category),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: new Text('Processing...')));
                  }
                },
                child: new Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _textFormField(String label, Function onSave) {
    return TextFormField(
            decoration: InputDecoration(labelText: label),
            validator: (value) => _validateNotEmpty(value),
            onSaved: onSave,
          );
  }

  String _validateNotEmpty(String value) {
    try {
      notEmpty(value);
      return null;
    } on InvalidInput catch(e) {
      return e.cause;
    }
  }

  String _validatePrice(String value) {
    try {
      nonNegative(value);
      return null;
    } on InvalidInput catch(e) {
      return e.cause;
    }
  }
}