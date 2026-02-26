import 'package:flutter/material.dart';

import 'package:postsapp/core/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postsapp/features/posts/presentation/bloc/add_delete_update_posts_bloc/add_delete_update_posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:postsapp/features/posts/presentation/pages/posts_page.dart';
import 'package:postsapp/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        theme: appTheme,
        home: PostsPage(),
      ),
    );
  }
}
