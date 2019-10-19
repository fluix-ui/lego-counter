
import 'package:fluix/fluix.dart';
import 'package:flutter/material.dart';
import 'package:lego_count/screens/count_set.dart';
import 'package:lego_count/screens/mysets.dart';
import 'package:lego_count/screens/set_details.dart';
import 'package:lego_count/screens/sets.dart';
import 'package:lego_count/utils/storage.dart';
import 'package:provider/provider.dart';

import 'package:lego_count/models/my_sets.dart';

void main(){
  //initStorage();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    MySets mysets = MySets();

    getMySets().then((sets) => {
      mysets.addAll(sets)
    });

    return MultiProvider(
      providers: [
        //ChangeNotifierProvider.value(value: LegoSets(),),
        ChangeNotifierProvider.value(value: mysets,)
      ],
      child: FluixApp(
        theme: FluidThemeData.vibrantCyan(),
        routes: {
          '/sets': (c) => SetsScreen(),
          '/': (c) => MySetsScreen(),
          '/count': (c) => CountScreen(),
          '/set': (c) => SetDetailsScreen(),
        },
      ),
    );

  }
}