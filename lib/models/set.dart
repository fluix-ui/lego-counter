import 'package:flutter/foundation.dart';

class LegoSet extends ChangeNotifier {
  String id;

  String name;

  int year;

  List<Part> showExisting;
  List<Part> showMissing;

  int partNum;
  List<Part> parts = [];
  List<Part> spareparts = [];

  String img = "";
  bool _cached;

  bool get cached => _cached != null && _cached;
  set cached(bool val) {
    _cached = val;
    notifyListeners();
  }

  LegoSet();

  LegoSet.fromJson(Map json, [List jsonparts]) {
    //json = json as Map<String, dynamic>;
    if (json["set_num"] != null) id = json["set_num"];
    if (json["name"] != null) name = json["name"];
    if (json["year"] != null) year = json["year"];
    if (json["cached"] != null) _cached = json["cached"];
    if (json["parts"] != null) jsonparts = json["parts"];
    if (json["spareparts"] != null)
      spareparts =
          json["spareparts"].map<Part>((part) => Part.fromJson(part)).toList();
    ;
    if (json["num_parts"] != null) partNum = json["num_parts"];
    if (json["set_img_url"] != null) img = json["set_img_url"] ?? "img not found";
    if (jsonparts != null)
      this.parts = jsonparts
          .map<Part>(
            (part) => Part.fromJson(part),
          )
          .toList();
    if (parts.isNotEmpty) {
      parts.sort((p1, p2) => p2.quantity.compareTo(p1.quantity));

      showExisting = parts.where((part) => part.owned > 0).toList();
      showMissing = parts.where((part) => part.owned < part.quantity).toList();
      if(showMissing.length == parts.length) {
        showMissing = [];
      }

      spareparts ??= parts.where((part) => part.isspare != null && part.isspare).toList();
      parts = parts.where((part) => part.isspare == null || !part.isspare).toList();
    }
  }

  Map toJson() {
    return {
      "set_num": id,
      "name": name,
      "num_parts": partNum,
      "set_img_url": img,
      "year": year,
      "parts": parts.map((part) => part.toJson()).toList(),
      "cached": cached,
      "spareparts": spareparts.map((part) => part.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  String getImg(
      {int size = 125,
      String url = "https://cdn.rebrickable.com/media/thumbs/sets/"}) {
    return url + id + '.jpg/${size}x${(size * 0.8).round()}.jpg';
  }
}

class Part extends ChangeNotifier {
  String id;
  String name;
  String img;
  int quantity;
  int _owned;
  bool isspare;
  double length;
  int get owned => _owned != null ? _owned : 0;
  set owned(int n){
    _owned = n;
    notifyListeners();
  } 

  increaseOwned() {
    if (_owned == quantity) return;
    _owned = owned + 1;
    notifyListeners();
  }
  decreaseOwned() {
    if (owned <= 0) return;
    _owned = owned - 1;
    notifyListeners();
  }

  Part({this.id, this.name, this.img, this.quantity, this.isspare});

  Part.fromJson(Map json) {
    var part = json["part"] ?? {};
    if (part["part_num"] != null) id = part["part_num"];
    if (part["name"] != null) name = part["name"];
    if (json["quantity"] != null) quantity = json["quantity"];
    if (json["owned"] != null) _owned = json["owned"];
    if (json["length"] != null) length = json["length"];
    if (part["part_img_url"] != null) img = part["part_img_url"];
    if (json["is_spare"] != null && json["is_spare"]) isspare = true;
    if(length == null){
      
      RegExp reg;
      if(name.contains("Axle")) reg = RegExp(r'Axle \1(\d+(\.\d)*)');
      if(name.contains("1 x")) reg = RegExp(r'Beam 1 x \1(\d+(\.\d)*)');
      if(reg != null) {
        var matches = reg.allMatches(name).toList();
        double nu = matches.isNotEmpty ?  double.tryParse(matches[0].group(1)) : null;
        if(nu != null && nu > 2) length = nu;
      }
    }
  }

  Map toJson() => {
        "part": {
          "name": name,
          "part_num": id,
          "part_img_url": img,
        },
        "quantity": quantity,
        "owned": _owned,
        "length": length,
        "is_spare": isspare,
      };
  String toCsv() => "$id,$name,$quantity,$owned,$isspare";

  String toText({int mode}){
    var res = "$id ($name) - ";
    switch (mode) {
      case 1: res += owned.toString();break;
      case 2: res += (quantity - owned).toString();break;
      default: res += quantity.toString();
    }
    return res;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
