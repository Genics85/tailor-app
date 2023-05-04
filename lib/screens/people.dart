import "dart:math";

import "package:flutter/material.dart";
import "package:tailor/widgets/colors.dart";

import "../widgets/app_text_field.dart";
import "add_people.dart";

class People extends StatefulWidget {
  const People({super.key});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
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
                        onTap: () {},
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
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, index) {
                        Color randomColor = Colors.primaries[
                            Random().nextInt(Colors.primaries.length)];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AddPeople()));
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(size.width, 60),
                                  foregroundColor: AppColors.colorDark,
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
                                    child: const SizedBox(
                                      child: Text(
                                        "A",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Something Here",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              )),
                        );
                      }))
            ]),
          ),
        ));
  }
}
