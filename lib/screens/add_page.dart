import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
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
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  int daysLeftCalculator() {
    DateTime currentDate = DateTime.now();
    var difference = ((dateTime.difference(currentDate).inHours / 24).round());
    return difference;
  }

  addToMeasurement(String label, String value) {
    setState(() {
      measurements.add([label, value]);
      // _labelController.text = "";
      // _valueController.text = "";
    });
  }

  File? stylePic;
  File? clothPic;
  DateTime dateTime = DateTime.now();
  String localStyleImagePath = "";
  String localClothImagePath = "";
  String styleSomething = "";
  String clothSomething = "";
  List<List> measurements = [];

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
    debugPrint("####################################");

    setState(() {
      localStyleImagePath = '$path/$styleFileName';
      localClothImagePath = '$path/$clothFileName';
      debugPrint(localStyleImagePath);
      debugPrint(localClothImagePath);
    });

    debugPrint("**************************************");
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
        dueDate:
            '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}',
        daysLeft: daysLeftCalculator(),
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
                    // localStyleImagePath.isNotEmpty
                    //     ? Container(
                    //         height: 100,
                    //         width: 100,
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             image: DecorationImage(
                    //                 image:
                    //                     FileImage(File(localStyleImagePath)))))
                    //     :const SizedBox(height: 5),
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
                              return ElevatedButton(
                                  onPressed: () {
                                    debugPrint("clicked");
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(size.width * 0.32,
                                          size.height * 0.057),
                                      foregroundColor: AppColors.colorDark,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      )),
                                  child: Text(
                                      "${measurements[index][0]}  |  ${measurements[index][1]}"));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              saveImagesToLocalStorage();
                              showAddDialog(context, shirt);
                              // debugPrint(localClothImagePath);
                              // debugPrint(localStyleImagePath);
                              // await WorkDatabase.instance.create(shirt);
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
                          debugPrint(localClothImagePath);
                          Navigator.pop(context);
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
