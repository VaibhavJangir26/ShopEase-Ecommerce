import 'package:flutter/material.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/screens/show_category_products.dart';
import 'package:shopease/view_modal/view_category_modal.dart';

class CategorySelectionUi extends StatefulWidget {
  const CategorySelectionUi({super.key});

  @override
  State<CategorySelectionUi> createState() => _CategorySelectionUiState();
}

class _CategorySelectionUiState extends State<CategorySelectionUi> {


  List<String> categoriesName = [
    "Electronics",
    "Jewellery",
    "Men's Clothing",
    "Women's Clothing",
  ];

  int currentIndex = 0;

  List<String> categoriesImage = [
    "assets/images/electronics.jpg",
    "assets/images/jewellery.jpg",
    "assets/images/menClothing.jpg",
    "assets/images/womenCloth.jpg",
  ];

  List<String> categoryId=[
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  SizedBox(
        width: width,
        height: height * .15,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesImage.length,
          itemBuilder: (context, index) {

            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShowProduct(categoryId: categoryId[index])));
                },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: width*.22,
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

                      categoryName(index),

                    ],
                  ),
                ),
              ),
            );
          },
        ),

    );
  }


  Widget categoryName(int index){
    return Text(
      categoriesName[index],
      style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900,),
      textAlign: TextAlign.center,
    );
  }

}
