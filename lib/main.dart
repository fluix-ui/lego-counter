import 'package:fluix/fluix.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lego_count/utils/router.dart';
import 'package:lego_count/utils/storage.dart';
import 'package:provider/provider.dart';

import 'models/my_sets.dart';
import 'models/sets.dart';

void main(){
  //initStorage();
  runApp(MyApp());
} 
//test

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Router router = new Router();
    Routes.configureRoutes(router);

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
        onGenerateRoute: router.generator,
      ),
    );

  }
}