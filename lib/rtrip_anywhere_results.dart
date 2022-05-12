import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ryanairapp/api/roundtrip_api.dart';
import 'package:ryanairapp/api/rt_anywhere_api.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'package:ryanairapp/widgets/widgets.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RoundTripAnywhereResults extends StatefulWidget {
  const RoundTripAnywhereResults({ Key? key }) : super(key: key);

  @override
  State<RoundTripAnywhereResults> createState() => _RoundTripAnywhereResultsState();
}

class _RoundTripAnywhereResultsState extends State<RoundTripAnywhereResults> {

  

  late Future<RoundtripAnywhereResults> roundTripAnywhereResults;

  late final _url = Uri.parse('https://www.ryanair.com/gb/en/trip/flights/select?adults=1&teens=0&children=0&infants=0&dateOut=${DepAirport.getResultDateOutbound()!.split('T')[0]}&dateIn=${DepAirport.getResultDateInbound()!.split('T')[0]}&isConnectedFlight=false&isReturn=true&discount=0&promoCode=&originIata=${DepAirport.getDepAirportCode()}&destinationIata=${DepAirport.getDestAirportCode()}&tpAdults=1&tpTeens=0&tpChildren=0&tpInfants=0&tpStartDate=${DepAirport.getResultDateOutbound()!.split('T')[0]}&tpEndDate=${DepAirport.getResultDateInbound()!.split('T')[0]}&tpDiscount=0&tpPromoCode=&tpOriginIata=${DepAirport.getDepAirportCode()}&tpDestinationIata=${DepAirport.getDestAirportCode()}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roundTripAnywhereResults = fetchRoundtripAnywhereResults();
  }
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       
      DepAirport.removeDateFromSelected();
      DepAirport.removeDateToSelected();
      Navigator.popAndPushNamed(context, '/roundtripRyanair');
      return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.roundtrip_any_title,
          ),
          leading: IconButton(
            icon: ImageIcon(AssetImage('assets/CheapFly.png')),
            onPressed: () {
              DepAirport.removeValueDestName();
              DepAirport.removeValueDestCode();
              DepAirport.removeDateFromSelected();
              DepAirport.removeDateToSelected();
              DepAirport.removeValueDestName();
              DepAirport.removeValueDestCode();
              Navigator.popAndPushNamed(context, '/homeRyanair');

            },
          ),
        ),
        body: Container(
          child: FutureBuilder<RoundtripAnywhereResults>(
            future: roundTripAnywhereResults,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.roundtripAnywhereResults.length,
                  itemBuilder: (context, index){
                    return SingleChildScrollView(
                    child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.roundtrip_res_out,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.roundtripAnywhereResults[index].outDepDate.split('T')[0])),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF073590),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.from,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w300,
                                                   ),
                                                ),
                                                Text(
                                                  snapshot.data!.roundtripAnywhereResults[index].outDepName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.roundtripAnywhereResults[index].outDepDate),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13.0,
                                                   ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Transform.rotate(
                                                  angle: math.pi / 2,
                                                  child:
                                                  Icon(
                                                    Icons.airplanemode_active,

                                                    ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.to,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w300,
                                                   ),
                                                ),
                                                Text(
                                                  snapshot.data!.roundtripAnywhereResults[index].outDestName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.roundtripAnywhereResults[index].outArrivalDate),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13.0,
                                                   ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.roundtrip_res_details_trip_dur,
                                                style: TextStyle(
                                                  color: Colors.grey
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                                                child: Text(
                                                  snapshot.data!.roundtripAnywhereResults[index].tripDuration.toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFF073590),
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!.roundtrip_res_details_trip_dur_days,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                          ),

                                        ],
                                      ),
                                      //Add here
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.roundtrip_res_inbound,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.roundtripAnywhereResults[index].inDepDate.split('T')[0])),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF073590),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.from,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w300,
                                                   ),
                                                ),
                                                Text(
                                                  snapshot.data!.roundtripAnywhereResults[index].inDepName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.roundtripAnywhereResults[index].inDepDate),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13.0,
                                                   ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Transform.rotate(
                                                  angle: math.pi / 2,
                                                  child:
                                                  Icon(
                                                    Icons.airplanemode_active,
                                                    ),
                                                ),

                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.to,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w300,
                                                   ),
                                                ),
                                                Text(
                                                  snapshot.data!.roundtripAnywhereResults[index].inDestName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.roundtripAnywhereResults[index].inArrivalDate),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13.0,
                                                   ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      //add here
                                      Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0, right: 3.0),
                                          child: Text(
                                            AppLocalizations.of(context)!.roundtrip_res_details_total_price,
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.roundtripAnywhereResults[index].totalPrice.toString()+renderCurrency(snapshot.data!.roundtripAnywhereResults[index].totalPriceCurrency),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFF073590),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // DepAirport.setResultDate(snapshot.data!.roundtripAnywhereResults[index].departureTime.split('T')[0]);
                                        DepAirport.setDestAirportCode(snapshot.data!.roundtripAnywhereResults[index].outDestCode);

                                        DepAirport.setResultDateOutbound(snapshot.data!.roundtripAnywhereResults[index].outDepDate);
                                        DepAirport.setResultDateInbound(snapshot.data!.roundtripAnywhereResults[index].inDepDate);



                                        

                                        
                                        launchUrl(
                                          Uri.parse('https://www.ryanair.com/${DepAirport.getlocale_country_user()}/${DepAirport.getlocale_lang_user()}/trip/flights/select?adults=1&teens=0&children=0&infants=0&dateOut=${DepAirport.getResultDateOutbound()!.split('T')[0]}&dateIn=${DepAirport.getResultDateInbound()!.split('T')[0]}&isConnectedFlight=false&isReturn=true&discount=0&promoCode=&originIata=${DepAirport.getDepAirportCode()}&destinationIata=${DepAirport.getDestAirportCode()}&tpAdults=1&tpTeens=0&tpChildren=0&tpInfants=0&tpStartDate=${DepAirport.getResultDateOutbound()!.split('T')[0]}&tpEndDate=${DepAirport.getResultDateInbound()!.split('T')[0]}&tpDiscount=0&tpPromoCode=&tpOriginIata=${DepAirport.getDepAirportCode()}&tpDestinationIata=${DepAirport.getDestAirportCode()}'),
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
                              ),
                              Row(
                                children: [
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
                            ],
                          ),
                          
                        ],
                      ),
                                  ],
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
                  }
                  );
                
                
              }else if (snapshot.hasError){
                return NoFlights(backPage: '/roundtripRyanair');
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
                            DepAirport.removedurationFrom();
                            DepAirport.removedurationTo();
                            DepAirport.removeValueDestName();
                            DepAirport.removeValueDestCode();
                            Navigator.popAndPushNamed(context, '/roundtripRyanair');
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
