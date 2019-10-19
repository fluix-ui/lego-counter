import 'package:flutter/widgets.dart';
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
  void addAll(List<LegoSet> mysets){
    sets.addAll(mysets);
    notifyListeners();
  }

  void update(LegoSet myset){
    var i = sets.indexWhere((item) => item.id == myset.id);
    if(i == -1) sets.add(myset);
    else sets[i] = myset;
    save();
    notifyListeners();
  }

  void save(){
    saveMySets(this);
  }

  void remove(LegoSet myset){
    var i = sets.indexWhere((item) => item.id == myset.id);
    sets.remove(sets[i]);
    save();
    notifyListeners();
  }

  void clear(){
    sets = [];
    notifyListeners();
  }

  List toJson(){
    return sets.map((sett) => sett.toJson()).toList();
  }

}