import 'package:sqflite/sqflite.dart';

class Work {
  final int? id;
  final String name;
  final String phone;
  final String description;
  final String price;

  const Work({
    required this.id,
    required this.name,
    required this.phone,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      "description": description,
      "price": price
    };
  }

  static Work fromJson(Map<String, Object?> json) {
    return Work(
        id: "_id" as int,
        name: "name",
        phone: "phone",
        description: "description",
        price: "price");
  }

  @override
  String toString() {
    return "Work{id:$id, name:$name, phone:$phone, description:$description, price:$price}";
  }
}
