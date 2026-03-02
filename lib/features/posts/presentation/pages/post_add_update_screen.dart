import 'package:flutter/material.dart';
import 'package:postsapp/core/widgets/custome_appbar.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_widgets/post_add_update_body.dart';

class PostAddUpdateScreen extends StatelessWidget {
  const PostAddUpdateScreen({this.post, super.key, required this.isUpdatePost});
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: isUpdatePost ? 'Update Post' : 'Add Post'),
      body: PostAddUpdateBody(post: post, isUpdatePost: isUpdatePost),
    );
  }
}
