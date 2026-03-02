import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/util/snack_bar_message.dart';
import 'package:postsapp/core/widgets/loading.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/post_add_update_screen.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_screen.dart';
import 'package:postsapp/features/posts/presentation/widgets/post_detail_widgets/delete_dialog.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 2),
            Text(post.body, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Divider(thickness: 2),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  label: const Text('update'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostAddUpdateScreen(isUpdatePost: true, post: post),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red[600]),
                  ),
                  label: const Text('delete'),
                  onPressed: () => deleteDialog(context, post.id!),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<
          AddDeleteUpdatePostsBloc,
          AddDeleteUpdatePostsState
        >(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostsState) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsScreen()),
                (route) => false,
              );
            } else if (state is ErrorAddDeleteUpdatePostsState) {
              Navigator.of(context).pop();
              SnackBarMessage().showErrorSnackBar(
                message: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostsState) {
              return const AlertDialog(content: Loading());
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      },
    );
  }
}
