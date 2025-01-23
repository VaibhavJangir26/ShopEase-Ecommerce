class TrendingModel {
  int? id;
  String? name;
  String? desc;
  double? price;
  String? color;
  String? image;
  String? category;
  RatingOfPdt? ratingOfPdt;

  TrendingModel({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.color,
    this.image,
    this.category,
    this.ratingOfPdt,
  });

  TrendingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    desc = json['desc'] ?? '';
    price = (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] ?? 0.0;
    color = json['color'] ?? '';
    image = json['image'] ?? '';
    category = json['category'] ?? '';
    ratingOfPdt = json['ratingOfPdt'] != null ? RatingOfPdt.fromJson(json['ratingOfPdt']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
      'category': category,
      'ratingOfPdt': ratingOfPdt?.toJson(),
    };
  }
}

class RatingOfPdt {
  double? rate;
  int? count;

  RatingOfPdt({this.rate, this.count});

  RatingOfPdt.fromJson(Map<String, dynamic> json) {
    rate = (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'] ?? 0.0;
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
