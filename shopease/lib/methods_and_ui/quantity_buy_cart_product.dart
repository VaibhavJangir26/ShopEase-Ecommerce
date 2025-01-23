import 'package:flutter/material.dart';

class QuantityBuyCartProduct extends StatefulWidget {
  const QuantityBuyCartProduct({super.key});

  @override
  State<QuantityBuyCartProduct> createState() => _QuantityBuyCartProductState();
}

class _QuantityBuyCartProductState extends State<QuantityBuyCartProduct> {
  int initialQuantity = 1;
  final List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height*.3,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text("In stock",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: height*.07,
            child: Row(
              children: [
                const Text("Quantity"),
                SizedBox(width: width*.05,),
                SizedBox(
                  width: 100,
                  child: DropdownButton<int>(
                    borderRadius: BorderRadius.circular(15),
                    value: initialQuantity,
                    isExpanded: true,
                    items: quantity.map((int value) {
                      return DropdownMenuItem<int>(
                        alignment: Alignment.center,
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        initialQuantity = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),


          SizedBox(
            width: width*.93,
            child: ElevatedButton(onPressed: (){

            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text("Buy Now")),
          ),


          SizedBox(
            width: width*.93,
            child: ElevatedButton(onPressed: (){

            }, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
            ), child: const Text("Add to cart")),
          ),
        ],
      ),
    );
  }
}
