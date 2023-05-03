class People {
  final int? id;
  final String name;
  final String phone;
  final String measurements;

  const People({
    this.id,
    required this.measurements,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "phone": phone,
      "measurements": measurements,
    };
  }

  People.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        name = json["name"],
        phone = json["phone"],
        measurements = json["measurements"];

  @override
  String toString() {
    return "People{id:$id, name:$name, phone:$phone,  measurements:$measurements}";
  }
}
