import 'package:bday/models/bday_for_listing.dart';
import 'package:bday/views/bday_delete.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'bday_modify.dart';
import 'package:bday/services/bday_service.dart';

class BDayList extends StatefulWidget {

  @override
  _BDayListState createState () => _BDayListState();

}

class _BDayListState extends State<BDayList> {

  BDayService get bdayService =>GetIt.I<BDayService>();

  List<BDayForListing> bdays = [];

  String formatDateTime (DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    bdays = bdayService.getBDayList();
    super.initState();
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
          return Dismissible(
            key: ValueKey(bdays[index].id),
            onDismissed: (direction) {

            },
            confirmDismiss: (direction) async {
              final result = await showDialog(
                context: context,
                builder: (_) => BDayDelete()
              );
              return result;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft),
            ),
            child: ListTile(
              title: Text(
                bdays[index].name + " " + bdays[index].fname,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text('Birthday : ${formatDateTime(bdays[index].bday)}'),
              onTap: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => BDayModify(bdayID: bdays[index].id)));
              },
            ),
          );
        },
        itemCount: bdays.length),
    );
  }

}