
class AirConditionerModel{

   int id;
   String brand;
   String description;
   String category;
   double price;
   double ac_ton;
   String image;
   RatingAc ratingAc;

  AirConditionerModel({
  required this.id,
  required this.brand,
  required this.description,
  required this.category,
  required this.price,
  required this.ac_ton,
  required this.image,
  required this.ratingAc,
  });

  factory AirConditionerModel.fromJson(Map<String,dynamic> json){
    return AirConditionerModel(
    id: json['id'],
    brand: json['brand'],
    description: json['description'],
    category: json['category'],
    price: json['price'],
    ac_ton: json['ac_ton'],
    image: json['image'],
    ratingAc: json['ratingAc'] !=null ? RatingAc.fromJson(json['ratingAc']): RatingAc(rates: 0.0, count: 0)
  );
  }

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'brand': brand,
      'description': description,
      'price': price,
      'ac_ton': ac_ton,
      'image': image,
      'category': category,
      'ratingAc': ratingAc,
    };
  }


}

class RatingAc {
  double? rates;
  int? count;

  RatingAc({this.rates, this.count});

  RatingAc.fromJson(Map<String, dynamic> json) {
    rates = (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'] ?? 0.0;
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rates,
      'count': count,
    };
  }
}




