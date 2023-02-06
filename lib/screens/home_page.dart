import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IconData> listOfIcons = [
    Icons.poll_outlined,
    Icons.add,
    Icons.home,
    Icons.photo_library_outlined,
    Icons.settings,
  ];
  List iconTitle = ["Finance","Add", "Home", "Posts", "Settings"];
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const SafeArea(
        child: Scaffold(
      body: Text("Homepage"),
    ));
  }
}
