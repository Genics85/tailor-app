import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tailor/database/sqllite.dart';
import 'package:tailor/models/people.dart';
import 'package:tailor/screens/landing_page.dart';

import '../widgets/big_text.dart';
import '../widgets/colors.dart';
import '../widgets/snackbar.dart';
import 'people_page.dart';

class PeopleDetailsPage extends StatefulWidget {
  const PeopleDetailsPage({super.key, required this.person});
  final People person;

  @override
  State<PeopleDetailsPage> createState() => _PeopleDetailsPageState();
}

class _PeopleDetailsPageState extends State<PeopleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Color randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.colorLight,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Customer's info",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDeleteDialog(
                        context,
                        widget.person.id!,
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.red,
                      size: 25,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              backgroundColor: randomColor,
              child: SizedBox(
                child: Text(
                  widget.person.name[0].toUpperCase(),
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Name: ",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            BigText(text: widget.person.name),
            const SizedBox(
              height: 10,
            ),
            const Text("Phone: ", style: TextStyle(fontSize: 18)),
            BigText(text: widget.person.phone),
            const SizedBox(
              height: 10,
            ),
            const Text("Measurements: ", style: TextStyle(fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: GridView.builder(
                itemCount: json.decode(widget.person.measurements).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 20),
                          foregroundColor: AppColors.colorDark,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          )),
                      child: Text(
                          "${json.decode(widget.person.measurements)[index][0].toString()} | ${json.decode(widget.person.measurements)[index][1].toString()}"));
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  showDeleteDialog(BuildContext context, int id) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Want to delete work forever?"),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          PeopleDatabase.instance.delete(widget.person.id!);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LandingPage(upIndex: 3,)));
                          showSnackBar(
                              context, "Customer successfully deleted", Colors.red);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green[600],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                              fontSize: 18,
                            )),
                        child: const Text('Continue')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red[600],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                              fontSize: 18,
                            )),
                        child: const Text('Cancel')),
                  ]),
            ));
  }
}
