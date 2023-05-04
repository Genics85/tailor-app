import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tailor/database/sqllite.dart';
import 'package:tailor/widgets/big_text.dart';

import '../models/people.dart';
import '../widgets/app_text_field.dart';
import '../widgets/colors.dart';
import '../widgets/snackbar.dart';

class AddPeople extends StatefulWidget {
  const AddPeople({super.key});

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  List<List> measurements = [];

  addToMeasurement(String label, String value) {
    setState(() {
      measurements.add([label, value]);
      _labelController.text = "";
      _valueController.text = "";
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    People person = People(
        name: _nameController.text,
        measurements: json.encode(measurements),
        phone: _phoneController.text);
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
                const SizedBox(
                  width: 10,
                ),
                const BigText(text: "Add Person's details"),
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      getTextField(_nameController, "Enter name here"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      getTextField(_phoneController, "Enter number here"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Measurements:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: getTextField(_labelController, "Label")),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 4,
                              child:
                                  getNumberTextField(_valueController, "Value"))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () => addToMeasurement(
                              _labelController.text.toUpperCase(),
                              _valueController.text),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.colorDark,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              textStyle: const TextStyle(
                                fontSize: 18,
                              )),
                          child: const Text('Add to measurements')),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 150,
                        child: GridView.builder(
                          itemCount: measurements.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            childAspectRatio: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 50,
                              height: 60,
                              child: ElevatedButton(
                                  onLongPress: () {
                                    _labelController.text =
                                        measurements[index][0];
                                    _valueController.text =
                                        measurements[index][1];
                                    setState(() {
                                      measurements.removeAt(index);
                                    });
                                  },
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(60, 60),
                                      foregroundColor: AppColors.colorDark,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                      )),
                                  child: Text(
                                      "${measurements[index][0]}  |  ${measurements[index][1]}")),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showAddDialog(context, person);
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 45),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          child: const Text("Done")),
                    ]),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  showAddDialog(BuildContext context, People person) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Want to add to person?'),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          PeopleDatabase.instance.create(person);
                          Navigator.pop(context);
                          resetInputs();
                          showSnackBar(
                              context, "Work successfully added", Colors.green);
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
                        child: const Text('Add')),
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

  void resetInputs() {
    setState(() {
      _nameController.text = "";
      _phoneController.text = "";
      _labelController.text = "";
      _valueController.text = "";
      measurements = [];
    });
  }
}
