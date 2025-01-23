import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/models/air_conditioner_model.dart';
import 'package:shopease/screens/show_ac_products.dart';
import 'package:shopease/view_modal/view_ac_model.dart';
import '../screens/category_product_detail_screen.dart';

class TopPickProduct extends StatefulWidget {
  const TopPickProduct({super.key});

  @override
  State<TopPickProduct> createState() => _TopPickProductState();
}

class _TopPickProductState extends State<TopPickProduct> {
  Future<List<AirConditionerModel>>? futureAcProducts;

  @override
  void initState() {
    super.initState();
    futureAcProducts = ViewAcModel().fetchAcModelData();
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
          FutureBuilder<List<AirConditionerModel>>(
            future: futureAcProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildLoadingShimmerTopPicks(width, height);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return SizedBox(
                  width: width,
                  height: height * 0.32,  // Adjusted the height to fill more space
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final acItem = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductDetailScreen(
                                id: acItem.id,
                                title: acItem.brand,
                                price: acItem.price,
                                description: acItem.description,
                                category: 'ac',
                                image: acItem.image,
                              ),
                            ),
                          );
                        },
                        child: buildAcProductItem(acItem, width, height),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShowAcProducts()));
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

  Widget buildLoadingShimmerTopPicks(double width, final height) {
    return SizedBox(
      width: width,
      height: height * 0.32,
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
              width: width * 0.25, // Adjusted size
              height: height * 0.2,
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

  Widget buildAcProductItem(AirConditionerModel acItem, double width, double height) {
    final indianPrice = acItem.price * 85;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: acItem.image.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: acItem.image,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.low,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.white,
                  child: Container(color: Colors.grey.shade400),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image_outlined),
              )
                  : const Icon(Icons.image_not_supported),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                acItem.brand.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 10),
              Text("${acItem.ac_ton.toString()} ton"),
            ],
          ),
          Text(acItem.category),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              '₹ ${indianPrice.toStringAsFixed(0)}',
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
