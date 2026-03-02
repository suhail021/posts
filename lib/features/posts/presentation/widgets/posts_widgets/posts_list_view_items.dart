import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_widgets/post_item.dart';

class PostsListViewItems extends StatelessWidget {
  const PostsListViewItems({super.key, required this.posts});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostItem(post: posts[index]);
      },
    );
  }
}
