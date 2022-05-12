import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ryanairapp/rtrip_results.dart';
import 'package:ryanairapp/utils/depairport.dart';


class RoundTripResultsApi{

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


  RoundTripResultsApi({

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

factory RoundTripResultsApi.fromJson(Map<String, dynamic> json){

  if(json['total'] == 0){

        throw Error();
      }else{


        return RoundTripResultsApi(

          outDepName: json['fares'][0]['outbound']['departureAirport']['name'],
          outDepCode: json['fares'][0]['outbound']['departureAirport']['iataCode'],
          outDepCountry: json['fares'][0]['outbound']['departureAirport']['countryName'],
          outDestName: json['fares'][0]['outbound']['arrivalAirport']['name'],
          outDestCode: json['fares'][0]['outbound']['arrivalAirport']['iataCode'],
          outDestCountry: json['fares'][0]['outbound']['arrivalAirport']['countryName'],
          outDepDate: json['fares'][0]['outbound']['departureDate'],
          outArrivalDate: json['fares'][0]['outbound']['arrivalDate'],
          outFlightNumber: json['fares'][0]['outbound']['flightNumber'],
          outPriceValue: json['fares'][0]['outbound']['price']['value'],
          outCurrencyCode: json['fares'][0]['outbound']['price']['currencyCode'],

          inDepName: json['fares'][0]['inbound']['departureAirport']['name'],
          inDepCode: json['fares'][0]['inbound']['departureAirport']['iataCode'],
          inDepCountry: json['fares'][0]['inbound']['departureAirport']['countryName'],
          inDestName: json['fares'][0]['inbound']['arrivalAirport']['name'],
          inDestCode: json['fares'][0]['inbound']['arrivalAirport']['iataCode'],
          inDestCountry: json['fares'][0]['inbound']['arrivalAirport']['countryName'],
          inDepDate: json['fares'][0]['inbound']['departureDate'],
          inArrivalDate: json['fares'][0]['inbound']['arrivalDate'],
          inFlightNumber: json['fares'][0]['inbound']['flightNumber'],
          inPriceValue: json['fares'][0]['inbound']['price']['value'],
          inCurrencyCode: json['fares'][0]['inbound']['price']['currencyCode'],


          totalPrice: json['fares'][0]['summary']['price']['value'],
          totalPriceCurrency: json['fares'][0]['summary']['price']['currencyCode'],
          tripDuration: json['fares'][0]['summary']['tripDurationDays'],
        );
      }
}

}


Future<RoundTripResultsApi> fetchRoundtripResults() async {

  final response = await http.get(Uri.parse('https://www.ryanair.com/api/farfnd/3/roundTripFares?=&arrivalAirportIataCode=${DepAirport.getDestAirportCode()}&departureAirportIataCode=${DepAirport.getDepAirportCode()}&durationFrom=${DepAirport.getdurationFrom()}&durationTo=${DepAirport.getdurationTo()}&inboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&inboundDepartureDateTo=${DepAirport.getToDateSelected()}&language=${DepAirport.getlocale_lang_user()}&limit=16&market=${DepAirport.getlocale_lang_user()}-${DepAirport.getlocale_country_user()}&offset=0&outboundDepartureDateFrom=${DepAirport.getFromDateSelected()}&outboundDepartureDateTo=${DepAirport.getToDateSelected()}&priceValueTo=2000'));


  try{

    final results = RoundTripResultsApi.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));

    DepAirport.setResultDateOutbound(results.outDepDate);
    DepAirport.setResultDateInbound(results.inDepDate);


    return results;
  }catch(e){
    return Future.error(e);
  }
}
