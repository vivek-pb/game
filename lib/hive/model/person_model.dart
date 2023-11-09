class PersonModel {
  PersonModel({
    this.name,
    this.age,
  });

  PersonModel.fromJson(dynamic json) {
    name = json['name'];
    age = json['age'];
  }
  String? name;
  num? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['age'] = age;
    return map;
  }
}
