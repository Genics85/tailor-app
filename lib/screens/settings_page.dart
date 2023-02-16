import 'package:flutter/material.dart';
import '../database/sqllite.dart';
import '../models/work.dart';
import '../widgets/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
       
        SizedBox(
          height: size.height * 0.8,
          child: FutureBuilder<List<Work>>(
              future: WorkDatabase.instance.getAllWorks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Work>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: ((context, index) {
                        var item = snapshot.data;
                        return Text(item.toString());
                      }));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )
      ]),
    ));
  }
}
