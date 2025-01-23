import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopease/methods_and_ui/category_selection_ui.dart';
import 'package:shopease/methods_and_ui/trending_products.dart';
import 'package:shopease/screens/offer_and_deal_of_day_screen.dart';
import 'package:shopease/methods_and_ui/top_pick_product.dart';
import 'package:shopease/widgets/my_app_bar.dart';
import 'package:shopease/widgets/my_drawer.dart';
import '../methods_and_ui/countdown_timer_for_deal.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // carousel slider
              carouselSlider(width,height),

              const CategorySelectionUi(),


              offerTitle(width, height, "TRENDING"),

              const TrendingProducts(),

              // Countdown Timer widget
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OfferAndDealOfDayScreen()));
                  },
                  child: const CountdownTimerForDeal()),

              offerTitle(width, height, "TOP PICKS, BEST PRICE"),

              const TopPickProduct(),


              SizedBox(height: height*.02,),
              offerSale1(width, height),

              offerTitle(width, height, "SPONSORED"),

              sponsoredProduct(width, height),


            ],
          ),
        ),
      ),
    );
  }

  Widget offerTitle(final width,final height,String title){
    return Container(
      width: width,
      height: height*.06,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child:  Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
    );
  }

  Widget carouselSlider(final width,final height) {
    return SizedBox(
      width: width,
      height: height*.3,
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
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          // Dots Indicator
          DotsIndicator(
            decorator: const DotsDecorator(color: Colors.grey, activeColor: Colors.blue,
            ),
            dotsCount: carouselImg.length,
            position: currentIndex,
          ),
        ],
      ),
    );
  }


  Widget offerSale1(final width,final height){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const OfferAndDealOfDayScreen()));
      },
      child: Container(
        width: width*.95,
        height: height*.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue.shade100,
        ),
        child: Image.asset("assets/images/offer.jpg",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.medium,
        ),

      ),
    );
  }


  Widget sponsoredProduct(final width,final height){
    List<String> sponsoredImg=[
      "assets/images/shoes.jpeg",
      "assets/images/rolex.jpeg"
    ];
    return SizedBox(
      width: width*.95,
      height: height*.4,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context,index){
            return Container(
              width: width*.15,
              height: height*.2,
              color: Colors.blueGrey,
              child: Image.asset(sponsoredImg[index],filterQuality: FilterQuality.medium,fit: BoxFit.fill,),
            );
          }
      )
    );
  }


}
