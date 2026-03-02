import 'package:flutter/material.dart';
import 'package:postsapp/core/widgets/custome_appbar.dart';
import 'package:postsapp/features/posts/presentation/pages/post_add_update_screen.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_widgets/posts_body.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: 'Posts'),
      body: PostsBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostAddUpdateScreen(isUpdatePost: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
