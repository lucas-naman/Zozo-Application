import 'package:flutter/material.dart';

class BDayModify extends StatefulWidget {

  @override 
  _BDayModifyState createState() => _BDayModifyState();

}

class _BDayModifyState extends State<BDayModify> {

  DateTime _date;

  String formatDateTime (DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Birthday')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child : Column(
          children: <Widget>[

            TextField(
              decoration: InputDecoration(
                hintText: 'Name'
              ),
            ),

            Container(height: 8),

            TextField(
              decoration: InputDecoration(
                hintText: 'Family Name'
              ),
            ),

            Container(height: 8),

            Row(children: <Widget>[
              Text(_date == null ? 'Nothing has been picked yet': formatDateTime(_date)),
              RaisedButton(
                child: Text('Pick a date'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.year)
                    .then((date) {
                      setState(() {
                        _date = date;
                      });
                    });
                },
              )
            ],),

            Container(height: 8),

            SizedBox (
              width: double.infinity,
              height: 35,
              child:
                RaisedButton(
                child: Text('Summit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}