import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ryanairapp/api/roundtrip_api.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'package:ryanairapp/widgets/widgets.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class RoundTripResults extends StatefulWidget {
  const RoundTripResults({ Key? key }) : super(key: key);

  @override
  State<RoundTripResults> createState() => _RoundTripResultsState();
}

class _RoundTripResultsState extends State<RoundTripResults> {

  

  bool _isVisibleOut = false;
  bool _textOutbound = true;

  bool _isVisibleIn = false;
  bool _textInbound = true;

  late Future<RoundTripResultsApi> roundTripResults;

  late final _url = Uri.parse('https://www.ryanair.com/${DepAirport.getlocale_country_user()}/${DepAirport.getlocale_lang_user()}/trip/flights/select?adults=1&teens=0&children=0&infants=0&dateOut=${DepAirport.getResultDateOutbound()!.split('T')[0]}&dateIn=${DepAirport.getResultDateInbound()!.split('T')[0]}&isConnectedFlight=false&isReturn=true&discount=0&promoCode=&originIata=${DepAirport.getDepAirportCode()}&destinationIata=${DepAirport.getDestAirportCode()}&tpAdults=1&tpTeens=0&tpChildren=0&tpInfants=0&tpStartDate=${DepAirport.getResultDateOutbound()!.split('T')[0]}&tpEndDate=${DepAirport.getResultDateInbound()!.split('T')[0]}&tpDiscount=0&tpPromoCode=&tpOriginIata=${DepAirport.getDepAirportCode()}&tpDestinationIata=${DepAirport.getDestAirportCode()}');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roundTripResults = fetchRoundtripResults();
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
      Navigator.popAndPushNamed(context, '/roundtripRyanair');
      return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.roundtrip_title,
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
        body: Container(
          child: FutureBuilder<RoundTripResultsApi>(
            future: roundTripResults,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Container(
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
                                  padding: EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0, left: 3.0),
                                            child: Text(
                                              AppLocalizations.of(context)!.roundtrip_res_out,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w300
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.outDepDate.split('T')[0])),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF073590),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.from,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w300,
                                                   ),
                                                ),
                                                Text(
                                                  snapshot.data!.outDepName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.outDepDate),
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
                                                  snapshot.data!.outDestName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.outArrivalDate),
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
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {


                                                 ( _isVisibleOut == true) ? _isVisibleOut = false : _isVisibleOut = true;
                                                 (_textOutbound == true) ? _textOutbound = false : _textOutbound = true;

                                                 ( _isVisibleIn == true) ? _isVisibleIn = false : '';
                                                 (_textInbound == false) ? _textInbound = true : '';

                                                 
                                                  
                                                
                                                });
                                              },
                                              style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size.zero),
                                                padding: MaterialStateProperty.all(EdgeInsets.all(2.0)),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                              child: _textOutbound ? Text(AppLocalizations.of(context)!.roundtrip_res_flight_details) : Text(AppLocalizations.of(context)!.roundtrip_res_hide_details) , 
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                            Visibility(
                                              visible: _isVisibleOut,
                                              child: 
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:5.0, bottom: 8.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only( bottom: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(context)!.roundtrip_res_details_outbound_title,
                                                                  style: TextStyle(
                                                                    fontSize: 13.0,
                                                                    fontWeight: FontWeight.w300,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data!.outDepName,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data!.outDepCode,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w300,
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    renderTime(snapshot.data!.outDepDate),
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Transform.rotate(
                                                                    angle: math.pi / 2,
                                                                    child:
                                                                    Icon(
                                                                      Icons.airplanemode_active,
                                                                      ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 1.0),
                                                                    child: Text(
                                                                      snapshot.data!.outFlightNumber,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.grey,
                                                                        fontSize: 13.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data!.outDestName,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data!.outDestCode,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w300,
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    renderTime(snapshot.data!.outArrivalDate),
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                                                                          child: Text(
                                                                            AppLocalizations.of(context)!.roundtrip_res_details_date,
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.outDepDate.split('T')[0])),
                                                                          style: TextStyle(
                                                                            color: Color(0xFF073590),
                                                                            fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                                                                          child: Text(
                                                                            AppLocalizations.of(context)!.roundtrip_res_details_price,
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          snapshot.data!.outPriceValue.toString()+renderCurrency(snapshot.data!.outCurrencyCode),
                                                                          style: TextStyle(
                                                                            color: Color(0xFF073590),
                                                                            fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0, left:3.0),
                                            child: Text(
                                              AppLocalizations.of(context)!.roundtrip_res_inbound,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w300
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.inDepDate.split('T')[0])),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF073590),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
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
                                                  snapshot.data!.inDepName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.inDepDate),
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
                                                    // color: Color.fromRGBO(241, 201, 51, 1),
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
                                                  snapshot.data!.inDestName,
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.bold,
                                                   ),
                                                ),
                                                Text(
                                                  renderTime(snapshot.data!.inArrivalDate),
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
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {


                                                 ( _isVisibleIn == true) ? _isVisibleIn = false : _isVisibleIn = true;
                                                 (_textInbound == true) ? _textInbound = false : _textInbound = true;

                                                 ( _isVisibleOut == true) ? _isVisibleOut = false : '';
                                                 (_textOutbound == false) ? _textOutbound = true : '';
                                                  
                                                
                                                });
                                              },
                                              style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size.zero),
                                                padding: MaterialStateProperty.all(EdgeInsets.all(2.0)),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                              child: _textInbound ? Text(AppLocalizations.of(context)!.roundtrip_res_flight_details) : Text(AppLocalizations.of(context)!.roundtrip_res_hide_details) , 
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                            Visibility(
                                              visible: _isVisibleIn,
                                              child: 
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:5.0, bottom: 8.0),
                                                      child: Column(
                                                        children: [
                                                    
                                                          Padding(
                                                            padding: const EdgeInsets.only( bottom: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(context)!.roundtrip_res_details_inbound_title,
                                                                  style: TextStyle(
                                                                    fontSize: 13.0,
                                                                    fontWeight: FontWeight.w300,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data!.inDepName,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data!.inDepCode,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w300,
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    renderTime(snapshot.data!.inDepDate),
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Transform.rotate(
                                                                    angle: math.pi / 2,
                                                                    child:
                                                                    Icon(
                                                                      Icons.airplanemode_active,
                                                                      ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 1.0),
                                                                    child: Text(
                                                                      snapshot.data!.inFlightNumber,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.grey,
                                                                        fontSize: 13.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data!.inDestName,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 15.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot.data!.inDestCode,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w300,
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    renderTime(snapshot.data!.inArrivalDate),
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top:8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                                                                          child: Text(
                                                                            AppLocalizations.of(context)!.roundtrip_res_details_date,
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode).format(DateTime.parse(snapshot.data!.inDepDate.split('T')[0])),
                                                                          style: TextStyle(
                                                                            color: Color(0xFF073590),
                                                                            fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 2.0, right: 5.0),
                                                                          child: Text(
                                                                            AppLocalizations.of(context)!.roundtrip_res_details_price,
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          snapshot.data!.inPriceValue.toString()+renderCurrency(snapshot.data!.inCurrencyCode),
                                                                          style: TextStyle(
                                                                            color: Color(0xFF073590),
                                                                            fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Column(
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
                                          snapshot.data!.totalPrice.toString()+renderCurrency(snapshot.data!.totalPriceCurrency),
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFF073590),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                      indent: 150.0,
                                      endIndent: 150.0,
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
                                            snapshot.data!.tripDuration.toString(),
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
                                  ],
                                ),
                              ),
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
