import 'package:hive/hive.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/sets.dart';
import 'package:path_provider/path_provider.dart';

Box box;

initStorage() async {
  if(box != null) return box;
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  box = await Hive.box('lego');
}

void saveMySets(MySets sets) async {
  await initStorage();
  await box.put("my_sets", sets.toJson());
  return;
}
Future<List<LegoSet>> getMySets() async {
  await initStorage();
  if(box == null || box['my_sets'] == null) return [];
  return (box['my_sets'] as List).map<LegoSet>((js) => LegoSet.fromJson(js)).toList();
}

Future<LegoSet> getMySet(String id) async {
  await initStorage();
  if(box == null || box['my_sets'] == null) return null;
  List res = (box['my_sets'] as List).where((_) => _["set_num"] == id).toList();
  if(res.isEmpty || res[0] == null) return null;
  return LegoSet.fromJson(res[0]);
}