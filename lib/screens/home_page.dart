import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tailor/screens/work_detail_page.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
import '../widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String daysLeftCalculator(String lastDay) {
    DateTime currentDate = DateTime.now();
    DateTime dueDate = DateTime.parse(lastDay);
    var difference = ((dueDate.difference(currentDate).inHours / 24).round());
    return difference.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(65),
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        expandedHeight: size.height * 0.05,
                        collapsedHeight: size.height * 0.2,
                        backgroundColor: AppColors.colorDark,
                        floating: true,
                        centerTitle: true,
                        title: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: size.width * 0.95,
                          height: size.height * 0.04,
                          child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(242, 255, 255, 255),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide.none),
                                  iconColor: AppColors.colorDark,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  isDense: true,
                                  hintText: "Search")),
                        ),
                      )
                    ]),
                body: const SizedBox(height: 1),
              ),
            ),
            body: SizedBox(
              width: size.width,
              child: FutureBuilder<List<Work>>(
                  future: WorkDatabase.instance.getAllWorks(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Work>> snapshot) {
                    if (snapshot.data != null) {
                      return Stack(alignment: Alignment.topCenter, children: [
                        ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, index) {
                              Work work = snapshot.data![index];
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WorkDetailsPage(
                                                  work: work,
                                                  daysLeft: daysLeftCalculator(
                                                      work.dueDate),
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize:
                                          Size(size.width, size.height * 0.09),
                                      foregroundColor: AppColors.colorDark,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                      )),
                                  child: Row(children: [
                                    Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        height: size.height * 0.075,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(
                                                    File(work.styleImg))))),
                                    Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        height: size.height * 0.075,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                    File(work.clothImg))))),
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            work.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 9),
                                          Text(work.description.length < 30
                                              ? work.description
                                              : "${work.description.substring(0, 30)}...")
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.timer_outlined),
                                            const SizedBox(height: 9),
                                            Text(
                                                daysLeftCalculator(
                                                    work.dueDate),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: work.daysLeft < 0
                                                      ? Colors.red
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              );
                            }),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 15),
                        //   width: size.width * 0.9,
                        //   child: TextField(
                        //       controller: _searchController,
                        //       decoration: InputDecoration(
                        //           filled: true,
                        //           fillColor:
                        //               const Color.fromARGB(242, 255, 255, 255),
                        //           border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(50),
                        //               borderSide: BorderSide.none),
                        //           iconColor: AppColors.colorDark,
                        //           suffixIcon: IconButton(
                        //             icon: const Icon(Icons.search),
                        //             onPressed: () {},
                        //           ),
                        //           contentPadding: const EdgeInsets.symmetric(
                        //               horizontal: 15),
                        //           isDense: true,
                        //           hintText: "Search")),
                        // ),
                      ]);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )));
  }
}
