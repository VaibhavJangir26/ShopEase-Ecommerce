import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/category_model.dart';
import '../screens/category_product_detail_screen.dart';
import '../view_modal/view_category_modal.dart';

class ShowSimilarProducts extends StatefulWidget {
  const ShowSimilarProducts({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<ShowSimilarProducts> createState() => _ShowSimilarProductsState();
}

class _ShowSimilarProductsState extends State<ShowSimilarProducts> {
  late Future<List<CategoryModal>> futureCategoryData;
  final ViewCategoryModal viewCategoryModal = ViewCategoryModal();

  @override
  void initState() {
    super.initState();
    futureCategoryData = viewCategoryModal.fetchCategoryData(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height*.5,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("See similar products",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Expanded(
            child: FutureBuilder<List<CategoryModal>>(
              future: futureCategoryData,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingShimmerEffect(width, height);
                }
                else if(snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                else if(snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return buildSimilarProductUi(width, height,snapshot);
                }
                else{
                  return const Center(child: Text("No similar products available."));
                }

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingShimmerEffect(double width, double height) {
    return SizedBox(
      width: width,
      height: height * .5,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.white,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: height * .31, color: Colors.grey.shade400,),
                  const SizedBox(height: 8),
                  Container(width: 100, height: 16, color: Colors.grey.shade400,),
                  const SizedBox(height: 8),
                  Container(width: 60, height: 16, color: Colors.grey.shade400,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSimilarProductUi(double width, double height,final snapshot){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final categoryItem = snapshot.data![index];
          final indianPrice = categoryItem.price * 85;
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryProductDetailScreen(
                id: categoryItem.id,
                title: categoryItem.title,
                price: categoryItem.price,
                description: categoryItem.description,
                category: categoryItem.category,
                image: categoryItem.image,
              ))
              );
            },
            child: Container(
              width: 150,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: height*.31,
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: categoryItem.image,
                      placeholder: (context, url) => Shimmer.fromColors(baseColor: Colors.grey.shade400, highlightColor: Colors.white, child: Container(color: Colors.grey.shade400,),),
                      errorWidget: (context,url,error) => const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(categoryItem.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(categoryItem.rating.rate.toString()),

                          RatingBarIndicator(
                            rating: categoryItem.rating.rate,
                            itemCount: 5,
                            itemSize: 16,
                            itemBuilder:(context,index)=> const Icon(Icons.star, color: Colors.amber),
                          ),

                          Text("(${categoryItem.rating.count})"),

                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("₹ ${indianPrice.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),

                ],
              ),
            ),
          );
        },

    );
  }
}
