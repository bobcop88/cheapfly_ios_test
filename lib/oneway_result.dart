import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ryanairapp/api/search_flight.dart';
import 'package:ryanairapp/onway.dart';
import 'package:ryanairapp/widgets/widgets.dart';
import 'dart:convert' show utf8;
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class ResultPageOneWay extends StatefulWidget {
  const ResultPageOneWay({ Key? key }) : super(key: key);

  @override
  State<ResultPageOneWay> createState() => _ResultPageOneWayState();
}

class _ResultPageOneWayState extends State<ResultPageOneWay> {

  

  late Future<FlightResults> flightResults;


  late final _url = Uri.parse('https://www.ryanair.com/${DepAirport.getlocale_lang_user()}/${DepAirport.getlocale_lang_user()}/trip/flights/select?adults=1&teens=0&children=0&infants=0&dateOut=${DepAirport.getResultDate()!.split('T')[0]}&dateIn=&isConnectedFlight=false&isReturn=false&discount=0&promoCode=&originIata=${DepAirport.getDepAirportCode()}&destinationIata=${DepAirport.getDestAirportCode()}&tpAdults=1&tpTeens=0&tpChildren=0&tpInfants=0&tpStartDate=${DepAirport.getFromDateSelected()}&tpEndDate=&tpDiscount=0&tpPromoCode=&tpOriginIata=${DepAirport.getDepAirportCode()}&tpDestinationIata=${DepAirport.getDestAirportCode()}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightResults = fetchFlightResults();
  }

   void _launchUrl() async {
     
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          
        DepAirport.removeDateFromSelected();
        DepAirport.removeDateToSelected();
        Navigator.popAndPushNamed(context, '/second');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.one_way_res_title
          ),
          leading: IconButton(
            icon: ImageIcon(AssetImage('assets/CheapFly.png')),
            onPressed: () {
              DepAirport.removeValueDestName();
              DepAirport.removeValueDestCode();
              DepAirport.removeDateFromSelected();
              DepAirport.removeDateToSelected();
              Navigator.popAndPushNamed(context, '/homeRyanair');
            },
          ),
        ),
    
        body: 
                Container(
                  child: FutureBuilder<FlightResults>(
                    future: flightResults,
                    builder: (context, snapshot){
                      if (snapshot.hasData) {
                        return Container(
                          child: Column(
                            children: [
                              Row(

                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,                              
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 5.0),
                                                        child: Text(
                                                          AppLocalizations.of(context)!.one_way_sub_title,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                        ),
                                                        ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top:8.0, bottom: 10.0),
                                                        child: Text(
                                                          DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.departureTime.split('T')[0])),
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                            color: Color.fromRGBO(7, 53, 144, 1),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                              snapshot.data!.flightNumber,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top:20.0),
                                                child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context)!.from,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 13.0,
    
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data!.departureAirportName,
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data!.departureAirportCode,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          renderTime(snapshot.data!.departureTime),
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                         Column(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
    
                                                            Transform.rotate(
                                                              angle: math.pi / 2,
                                                              child:
                                                              Icon(
                                                                Icons.airplanemode_active,
                                                                // color: Color.fromRGBO(241, 201, 51, 1),
                                                                ),
                                                            ),
                                                            ],
                                                          ),
                                                          
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context)!.to,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 13.0,
    
                                                          ),
                                                        ),
                                                        Text(
                                                          (snapshot.data!.arrivalAirportName),
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data!.arrivalAirportCode,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          renderTime(snapshot.data!.arrivalTime),
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 8.0, right: 3.0),
                                                              child: Text(
                                                                AppLocalizations.of(context)!.one_way_res_only,
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w300,
                                                                  fontSize: 12.0
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              (snapshot.data!.priceValue).toString()+renderCurrency(snapshot.data!.priceCurrency),
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color.fromRGBO(7, 53, 144, 1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {

                                                      launchUrl(
                                                        _url,
                                                        mode: LaunchMode.externalApplication,
                                                        );

                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!.one_way_res_check_btn,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(7, 53, 144, 1),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(241, 201, 51, 1)),
                                                      
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Tooltip(
                                                      triggerMode: TooltipTriggerMode.tap,
                                                      message: AppLocalizations.of(context)!.one_way_res_info_text,
                                                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(32, 145, 235,1),
                                                        ),
                                                          textStyle: TextStyle(
                                                            color: Colors.white,

                                                        ),
                                                      showDuration: Duration(seconds: 4),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 3.0),
                                                            child: Icon(
                                                              Icons.info_outline_rounded,
                                                              size: 15.0,
                                                              color: Color.fromRGBO(32, 145, 235,1),
                                                              ),
                                                          ),
                                                          Text(
                                                            AppLocalizations.of(context)!.one_way_res_info_title,
                                                            style: TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              color: Color.fromRGBO(32, 145, 235,1)
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            
                            ],
                          ),
                        );
                        
                      } else if (snapshot.hasError) {
                        return NoFlights(backPage: '/second');
                      }
                      return CircularProgression();
                    },
                  ),
    
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Color.fromRGBO(246, 137, 21,1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all( Color.fromRGBO(32, 145, 235,1)),
                        
                      ),
                              onPressed: () {
                                DepAirport.removeDateFromSelected();
                                DepAirport.removeDateToSelected();
                                Navigator.popAndPushNamed(context, '/second');
                              },
                              child: Text(
                                AppLocalizations.of(context)!.one_way_res_btn_search,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                  ),
                ),
             
        
      ),
    );
  }

  String renderTime(time)  {

    var fullTime = time.split('T')[1];

    var timeParts = fullTime.split(':');

    return '${timeParts[0]}:${timeParts[1]}';

  }

  String renderCurrency(currency){

    if(currency == 'EUR'){
      return String.fromCharCode(0x20AC);
    }else if(currency == 'GBP'){

      return String.fromCharCode(0x00A3);
    }else{

      return currency;
    }


  }

 
    
     


    
    
    

    

  
}