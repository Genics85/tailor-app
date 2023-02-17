import 'package:flutter/material.dart';
import './home_page.dart';
import './posts_page.dart';
import './add_page.dart';
import './finance_page.dart';
import './settings_page.dart';
import '../widgets/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> listOfPages = [
    AddPage(),
    FinancePage(),
    HomePage(),
    PostsPage(),
    SettingsPage()
  ];
  List<IconData> listOfIcons = [
    Icons.add,
    Icons.poll_outlined,
    Icons.home,
    Icons.photo_library_outlined,
    Icons.settings,
  ];
  List iconTitle = ["Add", "Stats", "Home", "Posts", "Settings"];
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: appNavigationBar(size),
      body: listOfPages.elementAt(currentIndex),
    );
  }

  Widget appNavigationBar(Size size) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(bottom: 7, left: 10),
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
    );
  }
}
