import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:lego_count/models/set.dart';
export 'package:lego_count/models/set.dart';

@HiveType()
class LegoSets extends ChangeNotifier {
  @HiveField(0)
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