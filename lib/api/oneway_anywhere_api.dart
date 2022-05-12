import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ryanairapp/utils/depairport.dart';


class OneWayAnywhereResults {

  final List<OneWayFlights> oneWayAnywhereResults;

  OneWayAnywhereResults({required this.oneWayAnywhereResults});

  factory OneWayAnywhereResults.fromJson(Map<String, dynamic> json){

    List<OneWayFlights> tempflights = [];

    if(json['total'] == 0) {
      throw Error();
    }

    for (int i = 0; i < json['fares'].length; i++){
      OneWayFlights flights = OneWayFlights.fromJson(json['fares'][i]);
      tempflights.add(flights);
    }
    return OneWayAnywhereResults(oneWayAnywhereResults: tempflights);
  }
}

class OneWayFlights{

  final String departureAirportName;
  final String departureAirportCode;
  final String arrivalAirportName;
  final String arrivalAirportCode;
  final String departureTime;
  final String arrivalTime;
  final String flightNumber;
  final double priceValue;
  final String priceCurrency;
  // final int totalCheck;


  OneWayFlights({

    required this.departureAirportName,
    required this.departureAirportCode,
    required this.arrivalAirportName,
    required this.arrivalAirportCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightNumber,
    required this.priceValue,
    required this.priceCurrency,
    // required this.totalCheck,
  });

  factory OneWayFlights.fromJson(Map<String, dynamic> json){

    

        return OneWayFlights(
        // totalCheck: json['total'],
        departureAirportName: json['outbound']['departureAirport']['name'],
        departureAirportCode: json['outbound']['departureAirport']['iataCode'],
        arrivalAirportName: json['outbound']['arrivalAirport']['name'],
        arrivalAirportCode: json['outbound']['arrivalAirport']['iataCode'],
        departureTime: json['outbound']['departureDate'],
        arrivalTime: json['outbound']['arrivalDate'],
        flightNumber: json['outbound']['flightNumber'],
        priceValue: json['outbound']['price']['value'],
        priceCurrency: json['outbound']['price']['currencyCode'],
      
        );



    
  }

}

Future<OneWayAnywhereResults> fetchOneWayAnywhereResults() async {

  final response = await http.get(Uri.parse('https://www.ryanair.com/api/farfnd/3/oneWayFares?=&departureAirportIataCode=${DepAirport.getDepAirportCode()}&language=${DepAirport.getlocale_lang_user()}&limit=16&market=${DepAirport.getlocale_lang_user()}-${DepAirport.getlocale_country_user()}&offset=0&outboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&outboundDepartureDateTo=${DepAirport.getToDateSelected()}&priceValueTo=2000'));

  try{

    final results = OneWayAnywhereResults.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));

    return results;
  }catch(e){
    return Future.error(e);
  }
}