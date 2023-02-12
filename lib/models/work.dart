import 'package:sqflite/sqflite.dart';

class Work {
  final int? id;
  final String name;
  final String phone;
  final String description;
  final String price;

  const Work({
    this.id,
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

  Work.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        name = json["name"],
        phone = json["phone"],
        description = json["description"],
        price = json["price"];

  @override
  String toString() {
    return "Work{id:$id, name:$name, phone:$phone, description:$description, price:$price}";
  }
}
