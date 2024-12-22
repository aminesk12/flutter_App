import 'package:e_shop/models/users.dart';
import 'package:floor/floor.dart';



@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM users WHERE id = :id')
  Future<User?> findUserById(int id);

  @insert
  Future<void> insertUser(User user);

  @update
  Future<void> updateUser(User user);

  @delete
  Future<void> deleteUser(User user);
}
