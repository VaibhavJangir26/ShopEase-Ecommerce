import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/models/trending_model.dart';
import 'package:shopease/view_modal/view_trending_products.dart';
import 'package:shopease/widgets/my_app_bar.dart';
import 'category_product_detail_screen.dart';

class ShowTrendingProducts extends StatefulWidget {
  const ShowTrendingProducts({super.key});

  @override
  State<ShowTrendingProducts> createState() => _ShowTrendingProductsState();
}

class _ShowTrendingProductsState extends State<ShowTrendingProducts> {

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

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: MyAppBar(title: "ShopEase Trending"),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<TrendingModel>>(
                future: futureTrendingProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingShimmerEffect(width, height);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final trendingItem = snapshot.data![index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: const Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: .1)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductDetailScreen(
                                    id: trendingItem.id!,
                                    title: trendingItem.name!,
                                    price: trendingItem.price!,
                                    description: trendingItem.desc!,
                                    category: 'electronics',
                                    image: trendingItem.image!,
                                  ),
                                ),
                              );
                            },
                            contentPadding: const EdgeInsets.all(5),
                            leading: buildListTileLeading(width, height, trendingItem),
                            title: Text(
                              trendingItem.name!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: buildListTileSubtitle(index, trendingItem, height),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingShimmerEffect(final width, final height) {
    return SizedBox(
      width: width,
      height: height * .9,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.white,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: width * .25,
                height: height * .3,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: Container(
                width: width / 25,
                height: height * .03,
                margin: const EdgeInsets.only(bottom: 2.5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              subtitle: Container(
                width: width / 25,
                height: height * .05,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildListTileLeading(final width, final height, final trendingItem) {
    return SizedBox(
      width: width * .25,
      height: height * .15,
      child: trendingItem.image.isNotEmpty
          ? CachedNetworkImage(
        imageUrl: trendingItem.image!,
        fit: BoxFit.fill,
        placeholder: (context, url) => SpinKitFadingCircle(color: Colors.blue.shade200),
        errorWidget: (context, error, _) => const Icon(Icons.broken_image_outlined),
      )
          : const Center(child: Icon(Icons.image_not_supported)),
    );
  }

  Widget buildListTileSubtitle(final index, TrendingModel trendingItem, final height) {
    final indianPrice=trendingItem.price!*85;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(trendingItem.ratingOfPdt?.rate?.toString() ?? "0"),
            RatingBarIndicator(
              rating: trendingItem.ratingOfPdt?.rate ?? 0.0,
              itemCount: 5,
              itemSize: 16,
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
            ),
            Text("(${trendingItem.ratingOfPdt?.count ?? 0})"),
          ],
        ),
        Text("₹ ${indianPrice.toStringAsFixed(0)}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        const Text("FREE delivery"),
        SizedBox(
          height: height * 0.05,
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
            ),
            child: const Text("Add to cart"),
          ),
        ),
      ],
    );
  }


}
