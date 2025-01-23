import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/screens/category_product_detail_screen.dart';
import 'package:shopease/view_modal/view_category_modal.dart';
import 'package:shopease/widgets/my_app_bar.dart';
import 'package:shopease/widgets/my_drawer.dart';

class CategoryShowProduct extends StatefulWidget {
  const CategoryShowProduct({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<CategoryShowProduct> createState() => _CategoryShowProductState();
}

class _CategoryShowProductState extends State<CategoryShowProduct> {
  ViewCategoryModal viewCategoryModal = ViewCategoryModal();
  Future<List<CategoryModal>>? _futureCategoryData;

  @override
  void initState() {
    super.initState();
    _futureCategoryData = viewCategoryModal.fetchCategoryData(widget.categoryId);
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
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<CategoryModal>>(
                future: _futureCategoryData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingShimmerEffect(width,height);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final categoryItem = snapshot.data![index];
                        final indianPrice = categoryItem.price * 85;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration:  BoxDecoration(
                            border: const Border.symmetric(horizontal: BorderSide(color: Colors.grey,width: .1)),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: ListTile(

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

                            contentPadding: const EdgeInsets.all(5),

                            leading: buildListTileLeading(width, height, categoryItem),

                            title: Text(categoryItem.title, maxLines: 3, overflow: TextOverflow.ellipsis,),

                            subtitle: buildListTileSubtitle(index, indianPrice, categoryItem, height),


                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("Unknown error occurred"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingShimmerEffect(final width,final height) {
    return  SizedBox(
      width: width,
      height: height*.9,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.white,
        child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context,index){
            return ListTile(
              leading: Container(
                width: width*.25,
                height: height*.3,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: Container(
                width: width/25,
                height: height*.03,
                margin: const EdgeInsets.only(bottom: 2.5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              subtitle: Container(
                width: width/25,
                height: height*.05,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            }),
      ),
    );
  }

  Widget buildListTileLeading(final width, final height, final categoryItem) {
    return SizedBox(
      width: width*.25,
      height: height*.15,
      child: categoryItem.image.isNotEmpty ?CachedNetworkImage(
        imageUrl: categoryItem.image,
        fit: BoxFit.fill,
        placeholder:(context,url)=> SpinKitFadingCircle(color: Colors.blue.shade200,),
        errorWidget: (context,error,_)=>const Icon(Icons.broken_image_outlined),
      ) : const Center(child: Icon(Icons.image_not_supported)),
    );
  }

  Widget buildListTileSubtitle(final index, final indianPrice, final categoryItem, final height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(categoryItem.rating.rate.toString()),
            RatingBarIndicator(
              rating: categoryItem.rating.rate,
              itemCount: 5,
              itemSize: 16,
              itemBuilder:(context,index)=> const Icon(Icons.star, color:Colors.amber),
            ),
            Text("(${categoryItem.rating.count})"),
          ],
        ),
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
