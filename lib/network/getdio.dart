import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:listviewapi/models/listphim.dart';



const String api = "26763d7bf2e94098192e629eb975dab0&page=1";

class GetdioClient {
  var baseurl = "https://api.themoviedb.org/3";
  Future<List<Listphim>> getdata() async {
    var url = "$baseurl/discover/movie?api_key=$api";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((movie) => Listphim.fromJson(movie)).toList();
    } else {
      throw Exception("False to load movies!");
    }
  }
}