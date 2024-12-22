
import 'package:flutter/material.dart';

import '../models/photo.dart';
import '../services/photo_service.dart';

class PhotoProvider with ChangeNotifier {
  List<Photo> _data = [];
  List<Photo> get data => _data;
  PhotoProvider() {
    _load();
  }
  _load() async {
    _data = await PhotoService().fetchPhoto();
    notifyListeners();
  }

  add(Photo photo) {
    _data.insert(0, photo);
    notifyListeners();
  }

  remove(Photo photo) {
    _data.remove(photo);
    notifyListeners();
  }
}
