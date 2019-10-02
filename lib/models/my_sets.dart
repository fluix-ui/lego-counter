import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:lego_count/models/sets.dart';
import 'package:lego_count/utils/storage.dart';

class MySets extends ChangeNotifier {
  
  List<LegoSet> sets = [];

  bool add(LegoSet myset){
    if(sets.any((sett) => sett.id == myset.id)) return false;
    sets.add(myset);
    save();
    notifyListeners();
    return true;
  }
  addAll(List<LegoSet> mysets){
    sets.addAll(mysets);
    notifyListeners();
  }

  update(LegoSet myset){
    var i = sets.indexWhere((item) => item.id == myset.id);
    if(i == -1) sets.add(myset);
    else sets[i] = myset;
    save();
    notifyListeners();
  }

  save(){
    saveMySets(this);
  }

  remove(LegoSet myset){
    var i = sets.indexWhere((item) => item.id == myset.id);
    sets.remove(sets[i]);
    save();
    notifyListeners();
  }

  clear(){
    sets = [];
    notifyListeners();
  }

  toJson(){
    return sets.map((sett) => sett.toJson()).toList();
  }

}