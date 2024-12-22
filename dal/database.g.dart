// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PhotoDao? _photoDaoInstance;
  UserDao? _userDaoInstance;
  PostDao? _postDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Photo` (`id` INTEGER NOT NULL, `albumId` INTEGER NOT NULL, `title` TEXT NOT NULL, `url` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `email` TEXT NOT NULL, `phone` TEXT NOT NULL, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `image` TEXT NOT NULL, PRIMARY KEY (`id`))');
         await database.execute(
            'CREATE TABLE IF NOT EXISTS `Posts` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `body` TEXT NOT NULL, `userId` INTEGER NOT NULL, `tags` TEXT NOT NULL, `reactions` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PhotoDao get photoDao {
    return _photoDaoInstance ??= _$PhotoDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
  
  @override
  
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }
  

}


class _$PhotoDao extends PhotoDao {
  _$PhotoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _photoInsertionAdapter = InsertionAdapter(
            database,
            'Photo',
            (Photo item) => <String, Object?>{
                  'id': item.id,
                  'albumId': item.albumId,
                  'title': item.title,
                  'url': item.url
                },
            changeListener),
        _photoUpdateAdapter = UpdateAdapter(
            database,
            'Photo',
            ['id'],
            (Photo item) => <String, Object?>{
                  'id': item.id,
                  'albumId': item.albumId,
                  'title': item.title,
                  'url': item.url
                },
            changeListener),
        _photoDeletionAdapter = DeletionAdapter(
            database,
            'Photo',
            ['id'],
            (Photo item) => <String, Object?>{
                  'id': item.id,
                  'albumId': item.albumId,
                  'title': item.title,
                  'url': item.url
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Photo> _photoInsertionAdapter;

  final UpdateAdapter<Photo> _photoUpdateAdapter;

  final DeletionAdapter<Photo> _photoDeletionAdapter;

  @override
  Future<List<Photo>> findAllPhotos() async {
    return _queryAdapter.queryList('SELECT * FROM Photo',
        mapper: (Map<String, Object?> row) => Photo(
            albumId: row['albumId'] as int,
            id: row['id'] as int,
            title: row['title'] as String,
            url: row['url'] as String));
  }

  @override
  Stream<Photo?> findPhotoById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Photo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Photo(
            albumId: row['albumId'] as int,
            id: row['id'] as int,
            title: row['title'] as String,
            url: row['url'] as String),
        arguments: [id],
        queryableName: 'Photo',
        isView: false);
  }

  @override
  Future<void> insertPhoto(Photo photo) async {
    await _photoInsertionAdapter.insert(photo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePhoto(Photo photo) async {
    await _photoUpdateAdapter.update(photo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePhoto(Photo photo) async {
    await _photoDeletionAdapter.delete(photo);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'phone': item.phone,
                  'username': item.username,
                  'password': item.password,
                  'image': item.image,
                },
            changeListener),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'phone': item.phone,
                  'username': item.username,
                  'password': item.password,
                  'image': item.image,
                },
            changeListener),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'email': item.email,
                  'phone': item.phone,
                  'username': item.username,
                  'password': item.password,
                  'image': item.image,
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            username: row['username'] as String,
            password: row['password'] as String,
            image: row['image'] as String));
  }

  @override
  Future<User?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            username: row['username'] as String,
            password: row['password'] as String,
            image: row['image'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(User user) async {
    await _userUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}
class _$PostDao extends PostDao {
  _$PostDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _postInsertionAdapter = InsertionAdapter(
            database,
            'Posts',
            (Posts item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'userId': item.userId,
                  'tags': item.tags.join(','),  
                  'reactions': item.reactions,
                },
            changeListener),
        _postUpdateAdapter = UpdateAdapter(
            database,
            'Posts',
            ['id'],
            (Posts item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'userId': item.userId,
                  'tags': item.tags.join(','),  
                  'reactions': item.reactions,
                },
            changeListener),
        _postDeletionAdapter = DeletionAdapter(
            database,
            'Posts',
            ['id'],
            (Posts item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'userId': item.userId,
                  'tags': item.tags.join(','),  
                  'reactions': item.reactions,
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Posts> _postInsertionAdapter;

  final UpdateAdapter<Posts> _postUpdateAdapter;

  final DeletionAdapter<Posts> _postDeletionAdapter;

  @override
  Future<List<Posts>> findAllPosts() async {
    return _queryAdapter.queryList('SELECT * FROM Posts',
        mapper: (Map<String, Object?> row) => Posts(
            id: row['id'] as int,
            title: row['title'] as String,
            body: row['body'] as String,
            userId: row['userId'] as int,
            tags: (row['tags'] as String).split(','),  
            reactions: row['reactions'] as int));
  }

  @override
  Future<Posts?> findPostById(int id) async {
    return _queryAdapter.query('SELECT * FROM Posts WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Posts(
            id: row['id'] as int,
            title: row['title'] as String,
            body: row['body'] as String,
            userId: row['userId'] as int,
            tags: (row['tags'] as String).split(','),  
            reactions: row['reactions'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertPost(Posts post) async {
    await _postInsertionAdapter.insert(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePost(Posts post) async {
    await _postUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePost(Posts post) async {
    await _postDeletionAdapter.delete(post);
  }
}