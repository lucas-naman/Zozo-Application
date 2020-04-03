import 'package:bday/models/bday_for_listing.dart';
import 'package:bday/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BDayService {

  static const API = 'https://my-zozo-api.appspot.com/';
  // static const headers = {
  //   'field': 'value',
  // };

  Future<APIResponse<List<BDayForListing>>> getBDayList() {
    return http.get(API + 'bday',) // headers: headers)
    .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final bdays = <BDayForListing>[];
        for (var item in jsonData) {
          final bday = BDayForListing(
            id: item['id'].toString(),
            name: item['name'],
            fname: item['fname'],
            bday: DateTime.parse(item['date']),
          );
          print(bday);
          bdays.add(bday);
        }
        return APIResponse<List<BDayForListing>>(data: bdays);
      }
      return APIResponse<List<BDayForListing>>(error: true, errorMessage: "An error occured");
    })
    .catchError((_) {
      print(_);
      return APIResponse<List<BDayForListing>>(error: true, errorMessage: "An error occured");
    });
  }

}