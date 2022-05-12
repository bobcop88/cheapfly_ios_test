import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ryanairapp/utils/depairport.dart';


// class DateFlights {

//   final String firstDate;
//   final String lastDate;


//   const DateFlights({
//     required this.firstDate,
//     required this.lastDate,

//   });

//   factory DateFlights.fromJson(Map<String, dynamic> json){

//     return DateFlights(
//       firstDate: json[0],
//       lastDate: json[json.length -1],
//     );
//   }
// }


Future<List> fetchDateFlights() async {
  final response = await http.get(Uri.parse('https://www.ryanair.com/api/farfnd/3/oneWayFares/${DepAirport.getDepAirportCode()}/${DepAirport.getDestAirportCode()}/availabilities'));

  final List dates = json.decode(response.body);



  
  DepAirport.setFromDate(dates[0]);
  DepAirport.setToDate(dates[dates.length -1]);

 
  // https://services-api.ryanair.com/timtbl/3/schedules/${DepAirport.getDepAirportCode()}/${DepAirport.getDestAirportCode()}/period
  
  
  

  

  return dates;

}