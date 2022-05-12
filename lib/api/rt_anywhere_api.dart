import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ryanairapp/utils/depairport.dart';

// 
class RoundtripAnywhereResults {

  final List<RoundTripAnywhereResultsApi> roundtripAnywhereResults;

  RoundtripAnywhereResults({required this.roundtripAnywhereResults});

  factory RoundtripAnywhereResults.fromJson(Map<String, dynamic> json){

    List<RoundTripAnywhereResultsApi> tempflights = [];

    if(json['total'] == 0){

        throw Error();
      }

    for (int i = 0; i < json['fares'].length; i++){
      RoundTripAnywhereResultsApi flights = RoundTripAnywhereResultsApi.fromJson(json['fares'][i]);
      tempflights.add(flights);
    }
    return RoundtripAnywhereResults(roundtripAnywhereResults: tempflights);
  }
}

class RoundTripAnywhereResultsApi{

  final String outDepName;
  final String outDepCode;
  final String outDepCountry;
  final String outDestName;
  final String outDestCode;
  final String outDestCountry;
  final String outDepDate;
  final String outArrivalDate;
  final String outFlightNumber;
  final double outPriceValue;
  final String outCurrencyCode;

  final String inDepName;
  final String inDepCode;
  final String inDepCountry;
  final String inDestName;
  final String inDestCode;
  final String inDestCountry;
  final String inDepDate;
  final String inArrivalDate;

  final double inPriceValue;
  final String inCurrencyCode;
  final String inFlightNumber;
  final double totalPrice;
  final String totalPriceCurrency;
  final int tripDuration;


  RoundTripAnywhereResultsApi({

  required this.outDepName,
  required this.outDepCode,
  required this.outDepCountry,
  required this.outDestName,
  required this.outDestCode,
  required this.outDestCountry,
  required this.outDepDate,
  required this.outArrivalDate,
  required this.outFlightNumber,
  required this.outPriceValue,
  required this.outCurrencyCode,

  required this.inDepName,
  required this.inDepCode,
  required this.inDepCountry,
  required this.inDestName,
  required this.inDestCode,
  required this.inDestCountry,
  required this.inDepDate,
  required this.inArrivalDate,
  required this.inFlightNumber,
  required this.inPriceValue,
  required this.inCurrencyCode,

  required this.totalPrice,
  required this.totalPriceCurrency,
  required this.tripDuration,
});

factory RoundTripAnywhereResultsApi.fromJson(Map<String, dynamic> json){

  


        return RoundTripAnywhereResultsApi(

          outDepName: json['outbound']['departureAirport']['name'],
          outDepCode: json['outbound']['departureAirport']['iataCode'],
          outDepCountry: json['outbound']['departureAirport']['countryName'],
          outDestName: json['outbound']['arrivalAirport']['name'],
          outDestCode: json['outbound']['arrivalAirport']['iataCode'],
          outDestCountry: json['outbound']['arrivalAirport']['countryName'],
          outDepDate: json['outbound']['departureDate'],
          outArrivalDate: json['outbound']['arrivalDate'],
          outFlightNumber: json['outbound']['flightNumber'],
          outPriceValue: json['outbound']['price']['value'],
          outCurrencyCode: json['outbound']['price']['currencyCode'],

          inDepName: json['inbound']['departureAirport']['name'],
          inDepCode: json['inbound']['departureAirport']['iataCode'],
          inDepCountry: json['inbound']['departureAirport']['countryName'],
          inDestName: json['inbound']['arrivalAirport']['name'],
          inDestCode: json['inbound']['arrivalAirport']['iataCode'],
          inDestCountry: json['inbound']['arrivalAirport']['countryName'],
          inDepDate: json['inbound']['departureDate'],
          inArrivalDate: json['inbound']['arrivalDate'],
          inFlightNumber: json['inbound']['flightNumber'],
          inPriceValue: json['inbound']['price']['value'],
          inCurrencyCode: json['inbound']['price']['currencyCode'],


          totalPrice: json['summary']['price']['value'],
          totalPriceCurrency: json['summary']['price']['currencyCode'],
          tripDuration: json['summary']['tripDurationDays'],
        );
      
}

}

Future<RoundtripAnywhereResults> fetchRoundtripAnywhereResults() async {

  final response = await http.get(Uri.parse('https://www.ryanair.com/api/farfnd/3/roundTripFares?&departureAirportIataCode=${DepAirport.getDepAirportCode()}&durationFrom=${DepAirport.getdurationFrom()}&durationTo=${DepAirport.getdurationTo()}&inboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&inboundDepartureDateTo=${DepAirport.getToDateSelected()}&language=${DepAirport.getlocale_lang_user()}&limit=16&market=${DepAirport.getlocale_lang_user()}-${DepAirport.getlocale_country_user()}&offset=0&outboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&outboundDepartureDateTo=${DepAirport.getToDateSelected()}&priceValueTo=2000'));




  try{

    final results = RoundtripAnywhereResults.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));

    


    return results;
  }catch(e){
    return Future.error(e);
  }
}