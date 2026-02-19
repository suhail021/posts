import 'package:flutter/material.dart';
import 'package:postsapp/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts App',
     theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Posts '),
        ),
        body: const Center(
          child: Text('Posts App Home Page'),
         ),
      ),
    );
  }
}

 