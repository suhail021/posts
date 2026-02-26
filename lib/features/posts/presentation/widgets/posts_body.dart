import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/widgets/loading.dart';
import 'package:postsapp/core/widgets/message_display.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/widgets/posts_list_view_items.dart';

class PostsBody extends StatelessWidget {
  const PostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return Loading();
        } else if (state is LoadedPostsState) {
          return PostsListViewItems(posts: state.posts);
        } else if (state is ErrorPostsState) {
          return MessageDisplay(message: state.message);
        } else {
          return Loading();
        }
      },
    );
  }
}
