import 'package:dio/dio.dart';
import 'package:lego_count/models/set.dart';

const String key = "77507a559eae02002151061d44901210";

Dio dio = new Dio(BaseOptions(
  baseUrl: "https://rebrickable.com/api/v3/lego",
  headers: {
    'Authorization': key,
  },
  queryParameters: {
    "key":key,
  }
));

Future<Map> getSets([String search, int page = 1]) async {
  var res = await dio.get<Map>('/sets',queryParameters: {
    "page": page,
    "page_size":30,
    "ordering":"-num_parts",
    "key":key,
    "search": search
  });
  //print(res.request.uri);
  return res.data;
}

Future<LegoSet> getSet(String id) async {
  print("set/$id");
  var res = await Future.wait([
    dio.get<Map>('/sets/$id/'),
    dio.get<Map<String,dynamic>>('/sets/$id/parts',queryParameters: {
      "key":key,
      "page_size":10000,
    }),
  ]);

  print(res[0].request.uri);
  print(res[1].request.uri);

  if(res[0].data != null && res[1].data != null) return LegoSet.fromJson(
    res[0].data,
    res[1].data["results"],
  );
  return null;

}