import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/core/util/snack_bar_message.dart';
import 'package:postsapp/core/widgets/custom_text_form_field.dart';
import 'package:postsapp/features/posts/domain/entities/post.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts_bloc/add_delete_update_posts_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, this.post, required this.isUpdatePost});
  final Post? post;
  final bool isUpdatePost;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost && widget.post != null) {
      _bodyController.text = widget.post!.body;
      _titleController.text = widget.post!.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(label: 'Title', controller: _titleController),
            SizedBox(height: 15),
            CustomTextFormField(label: 'Body', controller: _bodyController),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: validateAndAddOrUpdatePost,
              child: Text(widget.isUpdatePost ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndAddOrUpdatePost() {
    final isValidForm = _formKey.currentState!.validate();
    final post = Post(
      id: widget.isUpdatePost ? widget.post!.id : null,
      title: _titleController.text,
      body: _bodyController.text,
    );
    if (!isValidForm) {
      SnackBarMessage().showErrorSnackBar(
        message: 'Please fill all the fields',
        context: context,
      );
    } else if (isValidForm) {
      if (widget.isUpdatePost) {
        context.read<AddDeleteUpdatePostsBloc>().add(
          UpdatePostEvent(post: post),
        );
      } else {
        context.read<AddDeleteUpdatePostsBloc>().add(AddPostEvent(post: post));
      }
    }
  }
}
