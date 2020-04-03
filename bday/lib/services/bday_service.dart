import 'package:bday/models/bday_for_listing.dart';

class BDayService {

  List <BDayForListing> getBDayList() {
    return [
      new BDayForListing(bday: DateTime.now(), id: "1", name: "ZOZO", fname: "ZOZO"),
      new BDayForListing(bday: DateTime.now(), id: "2", name: "ZAZA", fname: "ZAZA"),
      new BDayForListing(bday: DateTime.now(), id: "3", name: "ZEZE", fname: "ZEZE"),
      new BDayForListing(bday: DateTime.now(), id: "4", name: "ZUZU", fname: "ZUZU"),
    ];     
  }

}