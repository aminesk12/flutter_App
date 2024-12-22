import 'dart:convert';


import 'dart:io' show Platform;

import "package:http/http.dart" as http;

import '../models/post.dart';



class PostService {
  var devUrlPhoto = '';

  getUrlPost() {
    if (Platform.isAndroid) {
      return "http://192.168.1.2:8000/posts";
    }
    if (Platform.isIOS) {
      return "http://localhost:8000/posts";
    } else {
      return "http://localhost:8000/posts";
    }
  }

  Future<List<Posts>> fetchPost() async {
    final response = await http.get(Uri.parse(getUrlPost()));
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body)['posts'];
      return List.from(iterable.map((e) => Posts.fromJson(e)));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
