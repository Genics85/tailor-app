import 'package:flutter/material.dart';

import '../widgets/app_text_field.dart';
import '../widgets/colors.dart';

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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
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
              Expanded(flex: 4, child: getTextField(_labelController, "Label")),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 4, child: getNumberTextField(_valueController, "Value"))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
              onPressed: () => addToMeasurement(
                  _labelController.text.toUpperCase(), _valueController.text),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.colorDark,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        _labelController.text = measurements[index][0];
                        _valueController.text = measurements[index][1];
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
        ]),
      ),
    );
  }
}
