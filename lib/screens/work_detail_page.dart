import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tailor/database/sqllite.dart';
import 'package:tailor/screens/landing_page.dart';
import '../models/work.dart';
import '../widgets/colors.dart';
import '../widgets/snackbar.dart';

class WorkDetailsPage extends StatefulWidget {
  const WorkDetailsPage(
      {super.key, required this.work, required this.daysLeft});
  final daysLeft;
  final Work work;
  @override
  State<WorkDetailsPage> createState() => _WorkDetailsPageState();
}

class _WorkDetailsPageState extends State<WorkDetailsPage> {
  List<List<dynamic>> measurementsToArray(String arr) {
    final regExp = RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
    final result = regExp
        .allMatches(arr)
        .map((m) => m.group(0))
        .map((String? item) => item?.replaceAll(RegExp(r'[\ [\],]'), ''))
        .map((m) => [m])
        .toList();
    return result;
  }

  Future<void> deleteFiles(File stylePic, File clothPic) async {
    if (await stylePic.exists()) {
      await stylePic.delete();
    }
    if (await clothPic.exists()) {
      await clothPic.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var shirt = Work(
        id: widget.work.id,
        name: widget.work.name,
        description: widget.work.description,
        phone: widget.work.phone,
        price: widget.work.price,
        clothImg: widget.work.clothImg,
        styleImg: widget.work.styleImg,
        dueDate: widget.work.dueDate,
        daysLeft: widget.work.daysLeft,
        measurements: widget.work.measurements,
        done: 1,
        style: widget.work.style);

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: Container(
                padding: const EdgeInsets.all(15),
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(children: [
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
                            child: Text(
                              widget.work.name,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showDeleteDialog(context, widget.work.id!,
                                  widget.work.styleImg, widget.work.clothImg);
                            },
                            icon: const Icon(
                              Icons.delete_outlined,
                              color: Colors.red,
                              size: 25,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: size.width * 0.32,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.phone),
                                  Text("Call on phone")
                                ],
                              )),
                          Container(
                              width: size.width * 0.26,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.phone),
                                  Text("Whatsapp")
                                ],
                              )),
                          Container(
                              width: size.width * 0.32,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: Colors.red,
                                  ),
                                  Text("Due in ${widget.daysLeft} days")
                                ],
                              )),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.work.style,
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text("GH₵ ${widget.work.price.toString()}",
                            style: const TextStyle(fontSize: 22))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: size.height * 0.28,
                              width: size.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(widget.work.styleImg))))),
                          Container(
                              height: size.height * 0.28,
                              width: size.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(widget.work.clothImg))))),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width * 0.95,
                      height: widget.work.description.length * 0.5 + 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        widget.work.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Measurements:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                      child: GridView.builder(
                        itemCount: measurementsToArray(widget.work.measurements)
                            .length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                              onPressed: () {
                                debugPrint("clicked");
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      size.width * 0.32, size.height * 0.057),
                                  foregroundColor: AppColors.colorDark,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                  )),
                              child: Text(measurementsToArray(
                                      widget.work.measurements)[index][0]
                                  .toString()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDoneDialog(context, shirt);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width * 0.95, size.height * 0.065),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        child: const Text("Done")),
                    SizedBox(
                      height: size.height * 0.05,
                    )
                  ]),
                ))));
  }

  showDeleteDialog(
      BuildContext context, int id, String clothPic, String stylePic) {
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
                          deleteFiles(File(stylePic), File(clothPic));
                          WorkDatabase.instance.delete(widget.work.id!);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LandingPage()));
                          showSnackBar(
                              context, "Work successfully deleted", Colors.red);
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

  showDoneDialog(BuildContext context, Work shirt) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Want to mark this work as done?"),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          WorkDatabase.instance.update(shirt);
                          showSnackBar(
                              context, "Work marked as done", Colors.green);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LandingPage()));
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
