import 'package:flutter/material.dart';
import 'package:tailor/screens/work_detail_page.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
import '../widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: SizedBox(
              width: size.width,
              child: FutureBuilder<List<Work>>(
                  future: WorkDatabase.instance.getAllWorks(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Work>> snapshot) {
                    if (snapshot.data != null) {
                      return Stack(alignment: Alignment.topCenter, children: [
                        ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, index) {
                              Work work = snapshot.data![index];
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WorkDetailsPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize:
                                          Size(size.width, size.height * 0.09),
                                      foregroundColor: AppColors.colorDark,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      textStyle: const TextStyle(
                                        fontSize: 13,
                                      )),
                                  child: Row(children: [
                                    Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        height: size.height * 0.075,
                                        width: size.width * 0.15,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://www.tongesy.com/content/images/2022/07/DALL-E-2022-07-28-08.55.35---Man-making-coffee-in-style-of-Picasso--painting.png")))),
                                    Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        height: size.height * 0.075,
                                        width: size.width * 0.15,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://miro.medium.com/max/1024/1*e2-GB_Hdylczkj5PHh-lJQ.png")))),
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            work.name,
                                            style:const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 9),
                                          const Text(
                                              "Officia velit fugiat laborum some")
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.timer_outlined),
                                        SizedBox(height: 9),
                                        Text("3",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ))
                                      ],
                                    )
                                  ]),
                                ),
                              );
                            }),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: size.width * 0.9,
                          child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(242, 255, 255, 255),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide.none),
                                  iconColor: AppColors.colorDark,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  isDense: true,
                                  hintText: "Search")),
                        ),
                      ]);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )));
  }
}
