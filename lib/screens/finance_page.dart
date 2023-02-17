import 'package:flutter/material.dart';
import '../widgets/big_text.dart';
import '../widgets/colors.dart';
import 'done_works.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.colorLight,
            body: Container(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                const BigText(
                  text: "Statistics",
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WorksDone()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            color: AppColors.colorMid,
                            height: size.height * 0.2,
                            width: size.width * 0.95,
                            child: Text(
                              "Works Completed",
                              style: TextStyle(
                                  color: AppColors.colorLight, fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          color: AppColors.colorMid,
                          height: size.height * 0.2,
                          width: size.width * 0.95,
                          child: Text(
                            "Finance",
                            style: TextStyle(
                                color: AppColors.colorLight, fontSize: 30),
                          ),
                        ),
                      ],
                    ))
              ]),
            )));
  }
}
