import 'package:bday/models/bday_for_listing.dart';
import 'package:flutter/material.dart';
import 'bday_modify.dart';

class BDayList extends StatelessWidget {

  final bdays = [
    new BDayForListing(bday: DateTime.now(), id: "1", name: "ZOZO", fname: "ZOZO"),
    new BDayForListing(bday: DateTime.now(), id: "1", name: "ZAZA", fname: "ZAZA"),
    new BDayForListing(bday: DateTime.now(), id: "1", name: "ZEZE", fname: "ZEZE"),
    new BDayForListing(bday: DateTime.now(), id: "1", name: "ZUZU", fname: "ZUZU"),
  ];

  String formatDateTime (DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text('List of Birthday')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => BDayModify()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              bdays[index].name + " " + bdays[index].fname,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text('Birthday : ${formatDateTime(bdays[index].bday)}'),
          );
        },
        itemCount: bdays.length),
    );
  }

}