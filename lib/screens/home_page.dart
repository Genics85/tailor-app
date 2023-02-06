import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: Container(
              width: size.width,
              padding: const EdgeInsets.all(15),
              child: Stack(children: [
                SizedBox(
                  width: size.width * 0.9,
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(192, 255, 255, 255),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none),
                          iconColor: AppColors.colorDark,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          isDense: true,
                          hintText: "Search")),
                ),
                ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: size.width,
                        height: size.height * 0.09,
                        decoration: const BoxDecoration(color: Colors.white),
                      );
                    })
              ]),
            )));
  }
}
