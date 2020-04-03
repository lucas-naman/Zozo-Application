import 'package:bday/models/api_response.dart';
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

  APIResponse<List<BDayForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime (DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    _fetchBDays();
    super.initState();
  }

  _fetchBDays() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await bdayService.getBDayList();

    setState(() {
      _isLoading = false;
    });
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
      body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child:CircularProgressIndicator());
            }

            if (_apiResponse.error) {
              return Center(child: Text(_apiResponse.errorMessage));
            }

            return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].id),
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
                    _apiResponse.data[index].name + " " + _apiResponse.data[index].fname,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Birthday : ${formatDateTime(_apiResponse.data[index].bday)}'),
                  onTap: () {
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BDayModify(bdayID: _apiResponse.data[index].id)));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length);
          },
        ),
    );
  }

}