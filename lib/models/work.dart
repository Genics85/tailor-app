class Work {
  final int? id;
  final String name;
  final String phone;
  final String style;
  final String styleImg;
  final String clothImg;
  final String description;
  final String dueDate;
  final int daysLeft;
  final String measurements;
  final int price;
  final int? done;

  const Work(
      {this.id,
      required this.style,
      required this.styleImg,
      required this.clothImg,
      required this.dueDate,
      required this.daysLeft,
      required this.measurements,
      required this.name,
      required this.phone,
      required this.description,
      required this.price,
      this.done});

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      "style": style,
      "styleImg": styleImg,
      "clothImg": clothImg,
      "description": description,
      "price": price,
      "dueDate": dueDate,
      "daysLeft":daysLeft,
      "measurements": measurements,
      "done": done
    };
  }

  Work.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        name = json["name"],
        phone = json["phone"],
        style = json["style"],
        styleImg = json["styleImg"],
        clothImg = json["clothImg"],
        description = json["description"],
        price = json["price"],
        dueDate = json["dueDate"],
        daysLeft = json["daysLeft"],
        measurements = json["measurements"],
        done = json["done"];

  @override
  String toString() {
    return "Work{id:$id, name:$name, phone:$phone, description:$description, price:$price,style:$style , dueDate:$dueDate, measurements:$measurements, done:$done,styleImg:$styleImg,clothImg:$clothImg}, daysLeft:$daysLeft";
  }
}
