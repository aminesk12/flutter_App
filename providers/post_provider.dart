

import 'package:flutter/material.dart';


import '../models/post.dart';

import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  List<Posts> _data = [];
  List<Posts> get data => _data;

  PostProvider() {
    _load();
  }
  _load() async {
    _data = await PostService().fetchPost();
    notifyListeners();
  }

  add(Posts post) {
    _data.insert(0, post);

    notifyListeners();
  }

  remove(Posts post) {
    _data.remove(post);
    notifyListeners();
  }
}
