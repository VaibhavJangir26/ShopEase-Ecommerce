import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopease/models/air_conditioner_model.dart';

class ViewAcModel{

  String jsonPath="assets/jsonFiles/air_conditioner.json";

  Future<List<AirConditionerModel>> fetchAcModelData() async{

    try{
      var response=await rootBundle.loadString(jsonPath);
      var jsonData=jsonDecode(response);
      List<AirConditionerModel> acProducts=(jsonData as List).map((ac)=>AirConditionerModel.fromJson(ac)).toList();
      return acProducts;
    }
    catch (e){
      throw Exception("Error: ${e.toString()}");
    }

  }

}