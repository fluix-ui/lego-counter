import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:lego_count/models/set.dart';
export 'package:lego_count/models/set.dart';

class LegoSets extends ChangeNotifier {
  List<LegoSet> sets = [];
  int pagination = 1;
  int totalSets = 1;

  LegoSets();

  addAll(List<LegoSet> newsets) {
    sets.addAll(newsets);
    notifyListeners();
  }

  addJson(Map json) {
    if(json == null || json["results"] == null) return;
    addAll(
      json["results"].map<LegoSet>((js) => LegoSet.fromJson(js)).toList(),
    );
  }
  clear(){
    pagination = 1;
    sets = [];
    notifyListeners();
  }

  bool get isNotEmpty => sets != null && sets.isNotEmpty;
}