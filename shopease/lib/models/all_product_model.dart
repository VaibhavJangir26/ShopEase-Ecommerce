class AllProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  RatingProduct ratingOfItem;

  AllProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    required this.ratingOfItem,
  });

  AllProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = (json['price'] is int)
            ? (json['price'] as int).toDouble()
            : json['price'],
        description = json['description'],
        category = json['category'],
        image = json['image'],
        ratingOfItem = RatingProduct.fromJson(json['rating']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['rating'] = ratingOfItem.toJson();
    return data;
  }
}

class RatingProduct {
  double? rate;
  int? count;

  RatingProduct({this.rate, this.count});

  RatingProduct.fromJson(Map<String, dynamic> json)
      : rate = (json['rate'] is int)
      ? (json['rate'] as int).toDouble()
      : json['rate'],
        count = json['count'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
