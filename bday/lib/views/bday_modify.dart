import 'package:flutter/material.dart';

class BDayModify extends StatefulWidget {

  final String bdayID;

  BDayModify({this.bdayID});

  @override 
  _BDayModifyState createState() => _BDayModifyState(bdayID: this.bdayID);

}

class _BDayModifyState extends State<BDayModify> {

  DateTime _date;
  String bdayID;
  bool get isEditing => bdayID != null;

  _BDayModifyState({this.bdayID});

  String formatDateTime (DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Modify Birthday': 'Create Birthday')),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(
                _date == null ? 'Nothing has been picked yet': 'Birthday: ${formatDateTime(_date)}',
                style: TextStyle(fontSize: 16),
              ),
              RaisedButton(
                child: Text('Pick a date', style: TextStyle(color: Colors.white)),
                color: _date == null ? Theme.of(context).errorColor: Theme.of(context).primaryColor,
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