


import 'package:e_shop/dal/post_dao.dart';
import 'package:e_shop/dal/user_dao.dart';

import 'package:e_shop/models/post.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/photo.dart';
import '../models/users.dart';
import 'photo_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Photo,Posts,User])
abstract class AppDatabase extends FloorDatabase {
  PhotoDao get photoDao;
  PostDao get postDao;
  UserDao get userDao;
  
}
