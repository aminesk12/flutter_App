import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/dal/post_dao.dart';

import '../dal/photo_dao.dart';
import '../models/photo.dart';
import '../models/post.dart';
import '../providers/photo_provider.dart';
import '../providers/post_provider.dart';
import '../values/theme.dart';
import 'cards.dart';

class DashBoard extends StatefulWidget {
  final PostDao postdao;
  final String lastName; // Added last name parameter

  const DashBoard({super.key, required this.postdao, required this.lastName}); // Modified constructor

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Posts> data = [];

  @override
  Widget build(BuildContext context) {
    data = Provider.of<PostProvider>(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts ${widget.lastName}'), // Display last name in the title
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyPostsScreen(postDao: widget.postdao),
              ),
            ),
            child: const Text(
              'MyPosts',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              alignment: Alignment.topRight,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  Column(
                    children: [
                      Icon(
                        Icons.archive_outlined,
                        color: themeApp.iconTheme.color,
                        size: themeApp.iconTheme.size,
                      ),
                      Text(
                        'Archive',
                        style: themeApp.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Column(
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: themeApp.iconTheme.color,
                        size: themeApp.iconTheme.size,
                      ),
                      Text(
                        'Delete',
                        style: themeApp.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onDismissed: (_) {
              setState(() {
                data.removeAt(index);
              });
            },
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: ListTile(
              title: Text(data[index].title),
              trailing: GestureDetector(
                onTap: () {
                  final newPost = Posts(
                    id: data[index].id,
                    title: data[index].title,
                    body: 'Body text', 
                    userId: 1,
                    tags: [], 
                    reactions: 0, 
                  );
                  widget.postdao.insertPost(newPost);
                },
                child: const CircleAvatar(
                  child: Icon(
                    color: Colors.black,
                    Icons.add_alarm_rounded,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PostProvider>(context, listen: false)
              .add(Posts(id: 10000,title: 'TEST TITLE',body: 'body',userId: 100000,tags: [],reactions: 2,));
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}

class MyPostsScreen extends StatelessWidget {
  final PostDao postDao;

  const MyPostsScreen({Key? key, required this.postDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPosts'),
      ),
      body: Center(
        child: Text('This is the MyPosts screen.'),
      ),
    );
  }
}
