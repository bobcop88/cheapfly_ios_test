import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ryanairapp/onway.dart';
import 'package:ryanairapp/autosuggestion_pages/auto_page.dart';
import 'package:ryanairapp/utils/depairport.dart';



class ArrivalAirport {
  final String name;
  final String code;
  final String? connecting;
  final String arrivalCountry;

  const ArrivalAirport({
    required this.name,
    required this.code,
    required this.connecting,
    required this.arrivalCountry,
  });

  static ArrivalAirport fromJson(Map<String, dynamic> json) => ArrivalAirport(
    name: json['arrivalAirport']['name'],
    code: json['arrivalAirport']['code'],
    connecting: json['connectingAirport'],
    arrivalCountry: json['arrivalAirport']['country']['name']
  );
}



// late var depCode =  DepAirport.getDepAirportCode();

// ${DepAirport.getDepAirportCode()}



class ArrivalAirportApi{

  
  

  static Future<List<ArrivalAirport>> getArrivalAirportSuggestion(String query) async {
    final url = Uri.parse('https://www.ryanair.com/api/locate/v1/autocomplete/routes?arrivalPhrase=&departurePhrase=${DepAirport.getDepAirportCode()}&market=${DepAirport.getlocale_lang_user()}-${DepAirport.getlocale_country_user()}');

    final response = await http.get(url);

    final List airports = json.decode(Utf8Decoder().convert(response.bodyBytes));
    final List airportFilter = airports.where((e) => e['connectingAirport'] == null ).toList();
    // print(airportFilter);
    
    airportFilter.sort(((a, b) => a['arrivalAirport']['name'].compareTo(b['arrivalAirport']['name'])));
    // print(depCode);

    


    return airportFilter.map((json) => ArrivalAirport.fromJson(json)).where((airport){

      final nameLower = airport.name.toLowerCase();
      final queryLower = query.toLowerCase();
      final codeLower = airport.code.toLowerCase();

      return nameLower.contains(queryLower) || codeLower.contains(queryLower);


    }).toList();

    // return airportFilter.map((json) => ArrivalAirport.fromJson(json)).toList();

    


  }
}

// Future<List<ArrivalAirport>> getArrivalAirportSuggestion() async {
//     final url = Uri.parse('https://www.ryanair.com/api/locate/v1/autocomplete/routes?arrivalPhrase=&departurePhrase=STN&market=en-gb');
//     final response = await http.get(url);

//     if(response.statusCode == 200){

//     final List airports = json.decode(response.body);
//     // final List airportFilter = airports.where((e) => e['connectingAirport'] == null ).toList();
//     // print(airportFilter);
    
//     airports.sort(((a, b) => a['arrivalAirport']['name'].compareTo(b['arrivalAirport']['name'])));
//     // print(depCode);

    


//     // return airportFilter.map((json) => ArrivalAirport.fromJson(json)).where((airport){

//     //   final nameLower = airport.name.toLowerCase();
//     //   final queryLower = query.toLowerCase();

//     //   return nameLower.contains(queryLower);


//     // }).toList();

//     return airports.map((json) => ArrivalAirport.fromJson(json)).toList();}

//     else{
//       throw Exception('${response.statusCode}');
//     }
// }