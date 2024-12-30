import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopease/view_modal/view_all_product_model.dart';
import 'package:shopease/models/all_product_model.dart';
import 'package:shopease/widgets/my_app_bar.dart';
import 'package:shopease/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categoriesImage = [
    "assets/images/electronics.jpg",
    "assets/images/jewellery.jpg",
    "assets/images/menClothing.jpg",
    "assets/images/womenCloth.jpg",
  ];

  List<String> categoriesName = [
    "Electronics",
    "Jewellery",
    "Men's Clothing",
    "Women's Clothing",
  ];

  int currentIndex = 0;

  List<String> carouselImg = [
    "assets/images/carsuelMenCloth.jpg",
    "assets/images/caruselWomenCloth.jpg",
    "assets/images/carJel.jpg",
  ];

  late Future<List<AllProductModel>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ViewAllProductModel().fetchAllProductData();
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Slider
              carouselSlider(width),

              // Horizontal Categories List
              selectCategory(width,height),

              // FutureBuilder for Product Data
              FutureBuilder<List<AllProductModel>>(
                future: _futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Error: ${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return ListTile(
                          leading: product.image != null && product.image!.isNotEmpty
                              ? Image.network(
                            product.image!,
                            height: 50,
                            width: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          )
                              : const Icon(Icons.image_not_supported),
                          title: Text(product.title ?? "No Title"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\$${product.price?.toStringAsFixed(2) ?? 'N/A'}"),
                              Text("Category: ${product.category ?? 'Unknown'}"),
                              if (product.rating != null)
                                Text(
                                  "Rating: ${product.rating!.rate?.toStringAsFixed(1) ?? 'N/A'} (${product.rating!.count ?? 0} reviews)",
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No products available."),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carouselSlider(final width) {
    return SizedBox(
      width: width,
      height: 200, // Fixed height for the carousel slider
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            itemCount: carouselImg.length,
            itemBuilder: (context, index, pageIndex) {
              return Container(
                width: width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(carouselImg[index]),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          // Dots Indicator
          DotsIndicator(
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: Colors.pink.shade400,
            ),
            dotsCount: carouselImg.length,
            position: currentIndex,
          ),
        ],
      ),
    );
  }

  Widget selectCategory(final width,final height){
    return SizedBox(
      width: width,
      height: height * .15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesImage.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width * .22,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(categoriesImage[index]),
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    categoriesName[index],
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
