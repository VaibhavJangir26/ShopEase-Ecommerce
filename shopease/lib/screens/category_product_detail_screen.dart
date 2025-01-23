import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopease/methods_and_ui/emi_calculator.dart';
import 'package:shopease/methods_and_ui/quantity_buy_cart_product.dart';
import 'package:shopease/methods_and_ui/show_similar_products.dart';
import 'package:shopease/methods_and_ui/size_of_products.dart';
import 'package:shopease/methods_and_ui/toast_message.dart';
import 'package:shopease/provider/wishlist_provider.dart';
import 'package:shopease/widgets/my_app_bar.dart';


class CategoryProductDetailScreen extends StatefulWidget {
  const CategoryProductDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  @override
  State<CategoryProductDetailScreen> createState() =>
      _CategoryProductDetailScreenState();
}

class _CategoryProductDetailScreenState
    extends State<CategoryProductDetailScreen> {
  int currentIndex = 0;



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
        child: SingleChildScrollView(
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                productTitle(width, height),

                const SizedBox(height: 5),

                displayProductImage(width, height),
                imageSliderInfo(width, height),

                SizeOfProducts(category: widget.category),

                productPrice(width, height),

                const QuantityBuyCartProduct(),

                deliveryAndReplacement(width, height),

                productDescription(width, height),

                ShowSimilarProducts(categoryId: widget.category),

                SizedBox(width: width, height: height*.04,),

              ],
            ),
          ),
        ),

    );
  }


  Widget productTitle(final width,final height){
    return Container(
      padding: const EdgeInsets.all(5),
      width: width,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      ),
      child: Text(widget.title, maxLines: 3, overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget displayProductImage(final width,final height){
    return CarouselSlider.builder(
      itemCount: 4,
      itemBuilder: (context, index, pageIndex){
        return  widget.image.isNotEmpty ? CachedNetworkImage(
          imageUrl: widget.image, fit: BoxFit.fill,
          placeholder:(context,url)=>Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(color: Colors.grey.shade400),
          ),
          errorWidget: (context,error,_)=> const Icon(Icons.broken_image_outlined),
        ) : const Icon(Icons.image_not_supported_outlined);
      },
      options: CarouselOptions(
        height: height*.4,
        viewportFraction: .95,
        initialPage: 0,
        enableInfiniteScroll: true,
        onPageChanged: (index, _) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget imageSliderInfo(final width,final height){
    return SizedBox(
      width: width,
      height: height * .07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: DotsIndicator(
                dotsCount: 5,
                position: currentIndex,
                decorator: const DotsDecorator(
                  activeColor: Colors.blue,
                  size: Size.square(6),
                  activeSize: Size(10, 10),
                ),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<WishlistProvider>(
                  builder: (context, value, child) {
                    bool isInWishlist = value.wishListItems.any((item) => item['name'] == widget.title);

                    return IconButton(
                      onPressed: () {
                        if (isInWishlist) {
                          value.removeItemFromFav(widget.title);
                          ToastMessage().showToastMsg("Remove from favourite");
                        } else {
                          value.addItemToFav(
                            widget.title,
                            widget.description,
                            widget.price,
                            widget.image,
                          );
                          ToastMessage().showToastMsg("Added to favourite");
                        }
                      },
                      icon: isInWishlist
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border_outlined),
                    );
                  },
                ),


                IconButton(
                    onPressed: (){

                    },
                    icon: const Icon(Icons.ios_share)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productPrice(final width,final height){
    final indianPrice=widget.price*85;
    final emiPrice=EmiCalculator.emiCalculation(indianPrice);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey,width: .5))
      ),
      child: indianPrice<2000?
            SizedBox(
              width: width,
              height: height*.125,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹ ${indianPrice.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 28),),
                  const Text("EMI options is not available."),
                ],
              ),
            ) : SizedBox(
              width: width,
              height: height*.18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹ ${indianPrice.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 28),),
                  const Text("EMI options is also available for this products."),
                  Row(
                    children: [
                      const Text('EMI starts at '),
                      Text('₹ ${emiPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.red),),
                    ],
                  ),
                  const Text("Inclusive of all taxes."),
                ],
              ),


      ),
    );
  }

  Widget productDescription(final width,final height){
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey,width: .5))
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Description",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          Text(widget.description,maxLines: 10,overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }

  Widget deliveryAndReplacement(final width,final height){
    return Container(
      width: width,
      height: height*.18,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey,width: .5)),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Shop with confidence",style: TextStyle(fontWeight: FontWeight.bold),),
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined),
              const Text("Free Delivery"),
              SizedBox(width: width*.125,),
              const Row(
                children: [
                  Icon(Icons.monetization_on_outlined),
                  Text("Pay on Delivery"),
                ],
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.h_mobiledata_outlined),
              const Text("Top Brands"),
              SizedBox(width: width*.15,),
              const Row(
                children: [
                  Icon(Icons.assignment_return_outlined),
                  Text("10 days replacement"),
                ],
              )],
          ),
          const Row(
            children: [
              Icon(Icons.security),
              Text("Secure Transaction"),
            ],
          ),
        ],
      ),
    );
  }


}


