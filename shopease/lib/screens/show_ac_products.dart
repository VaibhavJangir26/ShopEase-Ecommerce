import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/models/air_conditioner_model.dart';
import 'package:shopease/view_modal/view_ac_model.dart';
import 'package:shopease/widgets/my_app_bar.dart';
import 'category_product_detail_screen.dart';


class ShowAcProducts extends StatefulWidget {
  const ShowAcProducts({super.key});

  @override
  State<ShowAcProducts> createState() => ShowAcProductsState();
}

class ShowAcProductsState extends State<ShowAcProducts> {


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

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(title: "ShopEase"),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<AirConditionerModel>>(
                future: futureAcProducts,
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingShimmerEffect(width, height);
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  else if(snapshot.hasData){

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final acItem = snapshot.data![index];
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
                            contentPadding: const EdgeInsets.all(5),
                            leading: buildListTileLeading(width, height, acItem),
                            title: Text(
                              acItem.brand,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: buildListTileSubtitle(index, acItem, height),
                          ),
                        );
                      },
                    );
                  }

                  else{
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

  Widget buildListTileSubtitle(final index, AirConditionerModel acItem, final height) {
    final indianPrice = acItem.price * 85;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cooling Capacity ${acItem.ac_ton} ton"),
        Text("₹ ${indianPrice.toStringAsFixed(0)}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        const Text("FREE delivery"),
        SizedBox(
          height: height * 0.05,
          child: ElevatedButton(
            onPressed: () {},
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
