
import 'package:e_shop/dal/post_dao.dart';
import 'package:e_shop/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class MyCard extends StatelessWidget {
  final PostDao postDao;

  const MyCard({super.key, required this.postDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contents'),
      ),
      body: FutureBuilder<List<Posts>>(
        future: postDao.findAllPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].reactions as String),
              );
            },
          );
        },
      ),
    );
  }
}
