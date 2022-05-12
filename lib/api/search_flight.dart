import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ryanairapp/utils/depairport.dart';


class FlightResults{

  final String departureAirportName;
  final String departureAirportCode;
  final String arrivalAirportName;
  final String arrivalAirportCode;
  final String departureTime;
  final String arrivalTime;
  final String flightNumber;
  final double priceValue;
  final String priceCurrency;
  final int totalCheck;


  FlightResults({

    required this.departureAirportName,
    required this.departureAirportCode,
    required this.arrivalAirportName,
    required this.arrivalAirportCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightNumber,
    required this.priceValue,
    required this.priceCurrency,
    required this.totalCheck,
  });


  factory FlightResults.fromJson(Map<String, dynamic> json){


      if(json['total'] == 0){

        throw Error();
      }else{

        
    

    return FlightResults(
      totalCheck: json['total'],
      departureAirportName: json['fares'][0]['outbound']['departureAirport']['name'],
      departureAirportCode: json['fares'][0]['outbound']['departureAirport']['iataCode'],
      arrivalAirportName: json['fares'][0]['outbound']['arrivalAirport']['name'],
      arrivalAirportCode: json['fares'][0]['outbound']['arrivalAirport']['iataCode'],
      departureTime: json['fares'][0]['outbound']['departureDate'],
      arrivalTime: json['fares'][0]['outbound']['arrivalDate'],
      flightNumber: json['fares'][0]['outbound']['flightNumber'],
      priceValue: json['fares'][0]['outbound']['price']['value'],
      priceCurrency: json['fares'][0]['outbound']['price']['currencyCode'],


    );
    
      }
  }

  


}

Future<FlightResults> fetchFlightResults() async {

  


  final response = await http.get(Uri.parse('https://www.ryanair.com/api/farfnd/3/oneWayFares?=&arrivalAirportIataCode=${DepAirport.getDestAirportCode()}&departureAirportIataCode=${DepAirport.getDepAirportCode()}&language=${DepAirport.getlocale_lang_user()}&limit=100&market=${DepAirport.getlocale_lang_user()}-${DepAirport.getlocale_country_user()}&offset=0&outboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&outboundDepartureDateTo=${DepAirport.getToDateSelected()}&priceValueTo=10000'));


  try{

  final results = FlightResults.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));

  DepAirport.setResultDate(results.departureTime);
     
  return results;

  }catch(e){

    return Future.error(e);
  }
  


  
    
  
  
  




  
}
