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
              child: Stack(alignment: Alignment.topCenter, children: [
                ListView.builder(
                    itemCount: 12,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 5),
                        width: size.width,
                        height: size.height * 0.09,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(children: [
                          Container(
                              margin: const EdgeInsets.only(right: 6),
                              height: size.height * 0.075,
                              width: size.width * 0.15,
                              decoration:
                                  const BoxDecoration(color: Colors.red)),
                          Container(
                              margin: const EdgeInsets.only(right: 6),
                              height: size.height * 0.075,
                              width: size.width * 0.15,
                              decoration:
                                  const BoxDecoration(color: Colors.blue)),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Bra Akwasi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 9),
                                Text("Officia velit fugiat laborum some")
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.timer_outlined),
                              SizedBox(height: 9),
                              Text("3",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          )
                        ]),
                      );
                    }),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: size.width * 0.9,
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.colorLight,
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
              ]),
            )));
  }
}
