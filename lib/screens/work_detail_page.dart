import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class WorkDetailsPage extends StatefulWidget {
  const WorkDetailsPage({super.key});

  @override
  State<WorkDetailsPage> createState() => _WorkDetailsPageState();
}

class _WorkDetailsPageState extends State<WorkDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                width: size.width,
                child: Column(children: [
                  const Text(
                    "Bra Akwasi",
                    style: TextStyle(fontSize: 30),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.timer_outlined,
                                  color: Colors.red,
                                ),
                                Text("Due in 3days")
                              ],
                            )),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: size.height * 0.3,
                            width: size.width * 0.475,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://www.tongesy.com/content/images/2022/07/DALL-E-2022-07-28-08.55.35---Man-making-coffee-in-style-of-Picasso--painting.png")))),
                        Container(
                            height: size.height * 0.3,
                            width: size.width * 0.475,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://miro.medium.com/max/1024/1*e2-GB_Hdylczkj5PHh-lJQ.png"))))
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
                    width: size.width * 0.95,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6)),
                  )
                ]))));
  }
}
