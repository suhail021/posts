import 'package:flutter/material.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: 10,
        bottom: 10,
        right: 16,
        left: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.id.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(post.body, style: TextStyle(fontSize: 13)),
                Divider(thickness: 2, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
