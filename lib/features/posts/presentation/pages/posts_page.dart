import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_item.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_body.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts ')),
      body: PostsBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
