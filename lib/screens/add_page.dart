import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.colorLight,
          body: Container(
              padding: const EdgeInsets.all(10),
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Add new work", style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(size.width * 0.45, size.height * 0.20),
                                foregroundColor: AppColors.colorDark,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Add Style")
                              ],
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(size.width * 0.45, size.height * 0.20),
                                foregroundColor: AppColors.colorDark,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            child: Column(
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
                            ))
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
                    SizedBox(
                      height: size.height * 0.2,
                      child: TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(242, 255, 255, 255),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide.none),
                              iconColor: AppColors.colorDark,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Description")),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 4,
                              child: TextField(
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
                                              horizontal: 5),
                                      hintText: "Part"))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 4,
                              child: TextField(
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
                                              horizontal: 5),
                                      hintText: "Value")))
                        ])
                  ],
                ),
              )),
        ));
  }
}
