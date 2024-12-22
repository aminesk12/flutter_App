import 'dart:convert';

import 'dart:io' show Platform;
import "package:http/http.dart" as http;

import '../models/users.dart';

class UserService {
  var devUrlPhoto = '';
  List<User> _data = [];


  getUrlUser() {
    if (Platform.isAndroid) {
      return "http://192.168.1.2:8000/posts/users";
    }
    if (Platform.isIOS) {
      return "http://localhost:8000/users";
    } else {
      return "http://localhost:8000/users";
    }
  }

 fetchUsers() async {
    final response = await http.get(Uri.parse(getUrlUser()));
    if (response.statusCode == 200) {
      Iterable iterable = json.decode(response.body)["users"];
      _data =  List.from(iterable.map((e) => User.fromJson(e)));
    } else {
      throw Exception(response.statusCode);
    }
  }


}
