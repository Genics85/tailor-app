import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tailor/widgets/big_text.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
import '../widgets/colors.dart';
import 'work_detail_page.dart';

class WorksDone extends StatefulWidget {
  const WorksDone({Key? key}) : super(key: key);

  @override
  State<WorksDone> createState() => _WorksDoneState();
}

class _WorksDoneState extends State<WorksDone> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: Container(
                color: Colors.white,
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const BigText(text: "All Completed Works"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<List<Work>>(
                        future: WorkDatabase.instance.getAllDoneWorks(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Work>> snapshot) {
                          if (snapshot.data != null) {
                            return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        Work work = snapshot.data![index];
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WorkDetailsPage(
                                                            work: work,
                                                            daysLeft:"0",
                                                            done:true
                                                          )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(size.width, 80),
                                                foregroundColor:
                                                    AppColors.colorDark,
                                                backgroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                textStyle: const TextStyle(
                                                  fontSize: 13,
                                                )),
                                            child: Row(children: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 6),
                                                  height: size.height * 0.075,
                                                  width: size.width * 0.15,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              work.styleImg))))),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 6),
                                                  height: size.height * 0.075,
                                                  width: size.width * 0.15,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              work.clothImg))))),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      work.name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(height: 9),
                                                    Text(work.description
                                                                .length <
                                                            30
                                                        ? work.description
                                                        : "${work.description.substring(0, 30)}...")
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        "Gh ${work.price.toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 18)),
                                                  ))
                                            ]),
                                          ),
                                        );
                                      }),
                                ]);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  )
                ]))));
  }
}
