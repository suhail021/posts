import 'package:flutter/material.dart';
import 'package:postsapp/core/widgets/custome_appbar.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_widgets/post_add_update_body.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_widgets/post_detail_body.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({required this.post, super.key});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: 'Post Details'),
      body: PostDetailBody(post: post),
    );
  }
}
