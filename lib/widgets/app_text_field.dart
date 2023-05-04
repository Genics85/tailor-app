import 'package:flutter/material.dart';
import 'colors.dart';

Widget getTextField(TextEditingController controller, String hintText) {
  return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(242, 255, 255, 255),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none),
          iconColor: AppColors.colorDark,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: hintText));
}
Widget getNumberTextField(TextEditingController controller, String hintText) {
  return TextField(
    keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(242, 255, 255, 255),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none),
          iconColor: AppColors.colorDark,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: hintText));
}


