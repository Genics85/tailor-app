import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:tailor/widgets/big_text.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
import '../widgets/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/snackbar.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  addToMeasurement(String label, String value) {
    setState(() {
      measurements.add([label, value]);
      _labelController.text = "";
      _valueController.text = "";
    });
  }

  int daysLeftCalculator(String lastDay) {
    DateTime currentDate = DateTime.now();
    DateTime dueDate = DateTime.parse(lastDay);
    var difference = ((dueDate.difference(currentDate).inHours / 24).round());
    return difference;
  }

  File? stylePic;
  File? clothPic;
  DateTime dateTime = DateTime.now();
  String localStyleImagePath = "";
  String localClothImagePath = "";
  String styleSomething = "";
  String clothSomething = "";
  List<List> measurements = [];
  bool isChecked = false;

  resetInputs() {
    setState(() {
      _priceController.text = "";
      _nameController.text = "";
      _phoneController.text = "";
      _styleController.text = "";
      localClothImagePath = "";
      localStyleImagePath = "";
      _descriptionController.text = "";
      dateTime = DateTime.now();
      measurements = [];
      isChecked = false;
      _labelController.text = "";
      _valueController.text = "";
    });
  }

  pickStyle() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      stylePic = File(image.path);
    });
  }

  pickCloth() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      clothPic = File(image.path);
    });
  }

  saveImagesToLocalStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    final clothFileName = basename(clothPic!.path);
    final styleFileName = basename(stylePic!.path);
    await clothPic?.copy('$path/$clothFileName');
    await stylePic?.copy('$path/$styleFileName');
    setState(() {
      localStyleImagePath = '$path/$styleFileName';
      localClothImagePath = '$path/$clothFileName';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _styleController.dispose();
    _descriptionController.dispose();
    _labelController.dispose();
    _valueController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var shirt = Work(
        name: _nameController.text,
        description: _descriptionController.text,
        phone: _phoneController.text,
        price: _priceController.text.isNotEmpty
            ? int.parse(_priceController.text)
            : 0,
        clothImg: localClothImagePath,
        styleImg: localStyleImagePath,
        dueDate: dateTime.toString(),
        daysLeft: daysLeftCalculator(dateTime.toString()),
        measurements: measurements.toString(),
        done: 0,
        style: _styleController.text);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.colorLight,
          body: Container(
              padding: const EdgeInsets.all(15),
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BigText(text: "Add new work"),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(242, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none),
                            iconColor: AppColors.colorDark,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Name")),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(242, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none),
                            iconColor: AppColors.colorDark,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Phone number")),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Style:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _styleController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(242, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none),
                            iconColor: AppColors.colorDark,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Style name:")),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: pickStyle,
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(size.width * 0.45, size.height * 0.20),
                                foregroundColor: AppColors.colorDark,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                )),
                            child: stylePic == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Pick Style")
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7)),
                                    width: size.width * 0.45,
                                    height: size.height * 0.20,
                                    child: Image.file(
                                      File(stylePic!.path),
                                      fit: BoxFit.cover,
                                    ))),
                        ElevatedButton(
                            onPressed: pickCloth,
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(size.width * 0.45, size.height * 0.20),
                                foregroundColor: AppColors.colorDark,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                )),
                            child: clothPic == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Add Fabric")
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7)),
                                    width: size.width * 0.45,
                                    height: size.height * 0.20,
                                    child: Image.file(
                                      File(clothPic!.path),
                                      fit: BoxFit.cover,
                                    )))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description:",
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(242, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none),
                            iconColor: AppColors.colorDark,
                            contentPadding: const EdgeInsets.all(15),
                            hintText: "Description about work")),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Price:",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _priceController,
                                    decoration: InputDecoration(
                                        suffix: const Text("GH₵"),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            242, 255, 255, 255),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide.none),
                                        iconColor: AppColors.colorDark,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        hintText: "Price"))
                              ],
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Due date:",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () => pickDate(context),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(size.width * 0.5,
                                            size.height * 0.057),
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.colorDark,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.calendar_month),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            '${dateTime.day}/${dateTime.month}/${dateTime.year}')
                                      ],
                                    )),
                              ],
                            ))
                      ],
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: TextField(
                                      controller: _labelController,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              242, 255, 255, 255),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide.none),
                                          iconColor: AppColors.colorDark,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                          hintText: "Label"))),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 4,
                                  child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _valueController,
                                      decoration: InputDecoration(
                                          suffix: const Text("in"),
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              242, 255, 255, 255),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide.none),
                                          iconColor: AppColors.colorDark,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                          hintText: "Value")))
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () => addToMeasurement(
                                _labelController.text.toUpperCase(),
                                _valueController.text),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    size.width * 0.95, size.height * 0.057),
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.colorDark,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                )),
                            child: const Text('Add to measurements')),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: size.height * 0.2,
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
                                width: size.width * 0.28,
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
                                        // minimumSize: Size(size.width * 0.32,
                                        //     60),
                                        foregroundColor: AppColors.colorDark,
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                        )),
                                    child: Text(
                                        "${measurements[index][0]}  |  ${measurements[index][1]}")),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: AppColors.colorDark,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                                if (isChecked == true) {
                                  saveImagesToLocalStorage();
                                }
                              },
                            ),
                            const Text("Confirm all details before adding work")
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (isChecked == false) {
                                showSnackBar(
                                    context,
                                    "Confirm all details unckecked",
                                    Colors.red);
                              } else {
                                showAddDialog(context, shirt);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    size.width * 0.95, size.height * 0.057),
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.colorDark,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                )),
                            child: const Text('Add Work')),
                        SizedBox(
                          height: size.height * 0.08,
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }

  showAddDialog(BuildContext context, Work shirt) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Want to add to works?'),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          WorkDatabase.instance.create(shirt);
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

  pickDate(BuildContext context) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: AppColors.colorDark),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.colorDark,
                        foregroundColor: Colors.white))),
            child: child!,
          );
        }).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          dateTime = value;
        });
      }
    });
  }
}
