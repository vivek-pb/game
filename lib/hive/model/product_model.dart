class ProductModel {
  ProductModel({
    this.product,
    this.id,
  });

  ProductModel.fromJson(dynamic json) {
    product = json['product'];
    id = json['id'];
  }
  String? product;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    map['id'] = id;
    return map;
  }
}
