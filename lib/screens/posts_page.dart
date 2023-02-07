import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.colorLight,
      body: SizedBox(
          width: size.width,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, index) {
              return Container(
                width: size.width * 0.9,
                height: size.height * 0.7,
                margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.6,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://media.npr.org/assets/img/2022/07/19/dalle3_custom-6b01300a7345dd51abd00e7841fb929827dcb837.jpg"))),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.thumb_up,
                                        size: 40,
                                      )),
                                  const Text("34")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          size: 40, Icons.thumb_down_outlined)),
                                  const Text("12")
                                ],
                              )
                            ]),
                      ),
                    ]),
              );
            },
          )),
    ));
  }
}
