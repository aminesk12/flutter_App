import 'package:e_shop/models/post.dart';
import 'package:floor/floor.dart';


@dao
abstract class PostDao {
  @Query('SELECT * FROM posts')
  Future<List<Posts>> findAllPosts();

  @Query('SELECT * FROM posts WHERE id = :id')
  Future<Posts?> findPostById(int id);

  @insert
  Future<void> insertPost(Posts post);

  @update
  Future<void> updatePost(Posts post);

  @delete
  Future<void> deletePost(Posts post);
}
