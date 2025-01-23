class CartModel{

  final int? id;
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? pdtPrice;
  final int? quantity;
  final String? image;

  CartModel({
  required this.id,
  required this.productId,
  required this.productName,
  required this.initialPrice,
  required this.pdtPrice,
  required this.quantity,
  required this.image,
  });

  factory CartModel.fromJson(Map<String,dynamic> json){
    return CartModel(
      id: json['id'] ?? 0,
      productName: json['productName'] ?? "Not Saved",
      productId: json['productId'] ?? "Not Saved",
      pdtPrice: json['pdtPrice'] ?? 0.0,
      initialPrice: json['initialPrice'] ?? 0.0,
      quantity: json['quantity'] ?? 1,
      image: json['image'] ?? "Not Saved",
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'productId' : productId,
      'productName' : productName,
      'initialPrice' : initialPrice,
      'pdtPrice' : pdtPrice,
      'quantity' : quantity,
      'image' : image,
    };
  }


}