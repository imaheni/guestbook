import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListCardController {
  final VoidCallback initState;

  // Konstruktor untuk HomeController dengan initState sebagai parameter
  ListCardController({required this.initState});
  List<Map<String, String>> dataGuets = [];

  void getGuestsAll() async {
    try {
      var response = await Dio().get(
        "https://database-query.v3.microgen.id/api/v1/5e1db2df-b436-4ef5-97e3-bd7b6ba57b5b/guest",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
     if(response.statusCode == 200){
      for(var guest in response.data){
        
       dataGuets.add({
        "name": guest['name'],
        "institution": guest['institution'],
        "purpose": guest['purpose'],
        "recipient": guest['recipient'],
        "phone": guest['phone']
      });
      initState();
      }
     }
    } catch (e) {}
  }
}
