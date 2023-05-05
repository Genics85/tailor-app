import "dart:math";
import "package:flutter/material.dart";
import "package:tailor/database/sqllite.dart";
import "package:tailor/screens/add_people.dart";
import "package:tailor/screens/people_detail_page.dart";
import "package:tailor/widgets/colors.dart";

import "../models/people.dart";
import "../widgets/big_text.dart";

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  // Future<List<People>>? getPeople () async {
  //   return await PeopleDatabase.instance.getAllPeople();
  // }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.only(right: 5, left: 5),
            color: AppColors.colorLight,
            child: Column(children: [
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: AppColors.colorLight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
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
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                isDense: true,
                                hintText: "Search")),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPeople()));
                        },
                        child: Icon(
                          Icons.add_box,
                          size: 50,
                          color: AppColors.colorDark,
                        ),
                      )
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: FutureBuilder<List<People>>(
                      future: PeopleDatabase.instance.getAllPeople(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<People>> snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext context, index) {
                                  Color randomColor = Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)];
                                  People person = snapshot.data![index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PeopleDetailsPage(
                                                        person: person,
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(size.width, 60),
                                            foregroundColor:
                                                AppColors.colorDark,
                                            backgroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            textStyle: const TextStyle(
                                              fontSize: 13,
                                            )),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: randomColor,
                                              child: SizedBox(
                                                child: Text(
                                                  person.name[0].toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              person.name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        )),
                                  );
                                });
                          } else {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage("images/empty.png"),
                                    width: size.width * 0.7,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const BigText(text: "No Customer Added")
                                ]);
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))
            ]),
          ),
        ));
  }
}
