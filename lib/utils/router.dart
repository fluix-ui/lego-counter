import 'package:lego_count/screens/count_set.dart';
import 'package:lego_count/screens/set_details.dart';

import '../screens/main.dart';
import '../screens/sets.dart';
import '../screens/mysets.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class Routes {

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define('/home', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return MainScreen();
      })
    );
    router.define('/sets', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SetsScreen();
      })
    );
    // router.define('/set', handler: Handler(
    //   handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //     //if(params["id"] != null) Navigator.of(context).pushNamed('/');
    //     return SetDetailsScreen();
    //   })
    // );
    router.define('/set/:id', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        //if(params["id"] != null) Navigator.of(context).pushNamed('/');
        return SetDetailsScreen(params["id"][0]);
      })
    );

    router.define('/mysets', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return MySetsScreen();
      })
    );
    router.define('/', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return MySetsScreen();
      })
    );

    router.define('/count/:id', handler: Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        //if(params["id"] != null) Navigator.of(context).pushNamed('/');
        return CountScreen(params["id"][0]);
      })
    );
    // router.define('/record', handler: Handler(
    //   handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //     return RecordScreen();
    //   })
    // );
    // router.define('/test', handler: Handler(
    //   handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //     return TestScreen();
    //   })
    // );
  }
}