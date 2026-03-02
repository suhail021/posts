import 'package:flutter/material.dart';

class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomeAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
