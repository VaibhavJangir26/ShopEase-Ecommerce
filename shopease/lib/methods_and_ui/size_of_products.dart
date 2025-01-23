import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SizeOfProducts extends StatefulWidget {
  const SizeOfProducts({super.key,required this.category});
  final String category;
  @override
  State<SizeOfProducts> createState() => _SizeOfProductsState();
}

class _SizeOfProductsState extends State<SizeOfProducts> {
  List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  String defaultSelectedSize = "S";
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final categoryType = widget.category == "women's clothing" || widget.category == "men's clothing";
    return categoryType ? Container(
      width: width,
      height: height*.11,
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey,width: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Size",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                bool isSelected = defaultSelectedSize == sizes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      defaultSelectedSize = sizes[index];
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 70,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? Colors.pink.shade400 : Colors.blue.shade50,
                    ),
                    child: Text(sizes[index], style: const TextStyle(fontWeight: FontWeight.w700),),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ) : Container();
  }
}
