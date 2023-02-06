import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const SafeArea(
        child: Scaffold(
      body: Text("add page"),
    ));
  }
}
