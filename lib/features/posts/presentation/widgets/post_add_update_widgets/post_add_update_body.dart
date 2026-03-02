import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/util/snack_bar_message.dart';
import 'package:postsapp/core/widgets/loading.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_screen.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_add_update_widgets/form_widget.dart';

class PostAddUpdateBody extends StatelessWidget {
  const PostAddUpdateBody({super.key, this.post, required this.isUpdatePost});
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
        listener: (context, state) {
          if (state is MessageAddDeleteUpdatePostsState) {
            SnackBarMessage().showSuccessSnackBar(
              message: state.message,
              context: context,
            );
            // Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => PostsScreen()),
              (route) => false,
            );
          } else if (state is ErrorAddDeleteUpdatePostsState) {
            SnackBarMessage().showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }
        },

        builder: (context, state) {
          if (state is LoadingAddDeleteUpdatePostsState) {
            return const Loading();
          }
          return FormWidget(
            post: isUpdatePost ? post : null,
            isUpdatePost: isUpdatePost,
          );
        },
      ),
    );
  }
}
