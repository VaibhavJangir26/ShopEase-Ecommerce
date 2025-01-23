import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/screens/show_trending_products.dart';
import '../screens/category_product_detail_screen.dart';
import '../view_modal/view_trending_products.dart';
import '../models/trending_model.dart';

class TrendingProducts extends StatefulWidget {
  const TrendingProducts({super.key});

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {

  Future<List<TrendingModel>>? futureTrendingProducts;

  @override
  void initState() {
    super.initState();
    futureTrendingProducts = ViewTrendingProducts().fetchTrendingProducts();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          FutureBuilder<List<TrendingModel>>(
            future: futureTrendingProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingShimmer(width, height);

              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {

                return SizedBox(
                    height: height*.32,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductDetailScreen(
                                    id: product.id!,
                                    title: product.name!,
                                    price: product.price!,
                                    description: product.desc!,
                                    category: 'electronics',
                                    image: product.image!,
                                  ),
                                ),
                              );
                            },
                            child: buildProductItem(product, width, height));
                      },
                    ),

                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShowTrendingProducts()));
            },
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildLoadingShimmer(double width, double height) {
    return SizedBox(
      height: height * .32,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(
              width: width*.2,
              height: height*.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductItem(TrendingModel product, double width, double height) {
    final indianPrice=product.price!*85;
    return Container(
      width: width*.2,
      height: height*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
             width: width,
             height: height*.21,
             child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: product.image!.isNotEmpty ? CachedNetworkImage(
                    imageUrl: product.image!,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.low,
                    placeholder: (context,url)=>Shimmer.fromColors(baseColor: Colors.grey.shade400, highlightColor: Colors.white, child: Container(color: Colors.grey.shade400,)),
                    errorWidget: (context,url,error)=>const Icon(Icons.broken_image_outlined),
                ) : const Icon(Icons.image_not_supported),
              ),
           ),

          Text(product.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('₹ ${indianPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
