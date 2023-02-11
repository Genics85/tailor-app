import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../widgets/colors.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
    debugPrint("#########################");
    debugPrint(measurements.toString());
  }

  File? stylePic;
  File? clothPic;
  DateTime dateTime = DateTime.now();
  String localStyleImagePath = "";
  List<List> measurements = [];

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
    });
    return ['$path/$styleFileName', '$path/$clothFileName'];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.colorLight,
      body: Container(
          padding: const EdgeInsets.all(15),
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Add new work", style: TextStyle(fontSize: 24)),
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
                // ElevatedButton(
                //     onPressed: saveImagesToLocalStorage,
                //     child: Text("Upload")),
                // localStyleImagePath.length > 2
                //     ? Container(
                //         height: 100,
                //         width: 100,
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             image: DecorationImage(
                //                 image:
                //                     FileImage(File(localStyleImagePath)))))
                //     : SizedBox(height: 5),
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
                                controller: _priceController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        242, 255, 255, 255),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide.none),
                                    iconColor: AppColors.colorDark,
                                    contentPadding: const EdgeInsets.symmetric(
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
                                    minimumSize: Size(
                                        size.width * 0.5, size.height * 0.057),
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.colorDark,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  controller: _valueController,
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
                                      hintText: "Value")))
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () => addToMeasurement(
                            _labelController.text, _valueController.text),
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width * 0.95, size.height * 0.057),
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.colorDark,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                              fontSize: 18,
                            )),
                        child: const Text('Add to measurements'))
                  ],
                )
              ],
            ),
          )),
    ));
  }
}
