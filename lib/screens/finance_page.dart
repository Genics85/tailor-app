import 'package:flutter/material.dart';
import '../widgets/colors.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const SafeArea(
        child: Scaffold(
      body: Text("finance page"),
    ));
  }
}
