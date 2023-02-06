import 'package:flutter/material.dart';

import '../widgets/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<IconData> listOfIcons = [
    Icons.add,
    Icons.poll_outlined,
    Icons.home,
    Icons.photo_library_outlined,
    Icons.settings,
  ];
  List iconTitle = ["Add", "Finance", "Home", "Posts", "Settings"];
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(bottom: 7,left: 10),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : size.width * .01,
                      right: size.width * .03,
                      left: size.width * .03,
                    ),
                    width: size.width * .118,
                    height: index == currentIndex ? size.width * .014 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.colorDark,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .06,
                    color: index == currentIndex
                        ? AppColors.colorDark
                        : AppColors.colorMid,
                  ),
                  Text(
                    iconTitle[index],
                    style: TextStyle(
                        fontSize: 12.0,
                        color: index == currentIndex
                            ? AppColors.colorDark
                            : AppColors.colorMid),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
