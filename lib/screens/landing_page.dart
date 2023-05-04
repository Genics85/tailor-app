import 'package:flutter/material.dart';
import 'package:tailor/screens/people.dart';
import './home_page.dart';
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
    const FinancePage(),
    const AddPage(),
    const HomePage(),
    const PeoplePage(),
    const SettingsPage()
  ];
  List<IconData> listOfIcons = [
    Icons.poll_outlined,
    Icons.add,
    Icons.home_outlined,
    Icons.person_add_alt_outlined,
    Icons.settings_outlined
  ];
  List iconTitle = ["Stats","Add", "Home", "People","Settings"];
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar:appNavigationBar(size),
      body: listOfPages.elementAt(currentIndex),
    );
  }

  Widget appNavigationBar(Size size) {
    return Container(
      margin: const EdgeInsets.only(bottom:10),
      padding: const EdgeInsets.only(bottom:10,right: 10,left: 10),
      height: 60,
      alignment: Alignment.center,
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
