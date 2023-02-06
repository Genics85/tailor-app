import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const SafeArea(
        child: Scaffold(
      body: Text("post page"),
    ));
  }
}
