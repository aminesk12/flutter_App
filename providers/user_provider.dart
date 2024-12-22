
import 'package:e_shop/models/users.dart';
import 'package:e_shop/services/user_service.dart';
import 'package:flutter/material.dart';



class UserProvider with ChangeNotifier {
  List<User> _data = [];
  List<User> get data => _data;
  UserProvider() {
    _load();
  }
  _load() async {
    _data = await UserService().fetchUsers();
    notifyListeners();
  }

  add(User user) {
    _data.insert(0, user);
    notifyListeners();
  }

  remove(User user) {
    _data.remove(user);
    notifyListeners();
  }

  bool authenticate(String email, String password) {
    for (var user in _data) {
      if (user.username == email && user.password == password) {
        return true;
      }
    }
    return false;
  }
  String getLastName(String id){
    for (var user in _data) {
      if (user.username == id) {
        return user.lastName;
      }
    }
    return 'Do not exist';
  }
}


