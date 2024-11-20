import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
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
            SizedBox(height: height * .001),
            SizedBox(
              width: width,
              height: height * .3,
              child: CarouselSlider.builder(
                itemCount: carouselImg.length,
                itemBuilder: (context, index, pageIndex) {
                  return Container(
                    width: width * .8,
                    height: height * .29,
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
            ),
            DotsIndicator(
              decorator: DotsDecorator(
                color: Colors.grey,
                activeColor: Colors.pink.shade400,
              ),
              dotsCount: carouselImg.length,
              position: currentIndex,
            ),
            SizedBox(
              width: width,
              height: height * .13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesImage.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: width * .22,
                      height: height * .25,
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Item $index',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
