import 'package:flutter/material.dart';
import 'package:ryanairapp/autosuggestion_pages/auto_page_arrival.dart';
import 'package:ryanairapp/rtrip_anywhere_results.dart';
import 'package:ryanairapp/rtrip_results.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'package:ryanairapp/widgets/widgets.dart';
import 'dart:math' as math;

import 'autosuggestion_pages/auto_page.dart';
import 'date/dates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class RoundtripPage extends StatefulWidget {
  const RoundtripPage({ Key? key }) : super(key: key);

  @override
  State<RoundtripPage> createState() => _RoundtripPageState();
}

class _RoundtripPageState extends State<RoundtripPage> {

  bool checkedValue = false;

  String depAirportName = '';
  String depAirportCode = '';
  String destAirportName = '';
  String destAirportCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // depAirportName = DepAirport.getDepAirport() ?? 'Select Departure';
    depAirportCode = DepAirport.getDepAirportCode() ?? '';
    // destAirportName = DepAirport.getDestAirport() ?? 'Select Destination';
    destAirportCode = DepAirport.getDestAirportCode() ?? '';
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DepAirport.removeValueDestName();
        DepAirport.removeValueDestCode();
        DepAirport.removeDateFromSelected();
        DepAirport.removeDateToSelected();

        Navigator.popAndPushNamed(context, '/homeRyanair');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.roundtrip_title
          ),
          centerTitle: true,
          leading: IconButton(
            icon: ImageIcon(AssetImage('assets/CheapFly.png')),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: 
                                  
                                     Container(
                                      
                                      height: 90.0,
                                      child: Image.asset('assets/plane_route.png'),
                                    ),
                                  ),
                                  ],
                                ),
                                Expanded(
                              child: 
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
              
                                        if(destAirportName != 'Arrival Airport'){
                                          DepAirport.removeValueDestName();
                                          DepAirport.removeValueDestCode();
                                        }
              
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const AutoPage(valDep: 'roundtrip'),
                                            ),
                                             );
                                             
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!.from,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                
                                            Text(
                                              DepAirport.getDepAirport() ?? AppLocalizations.of(context)!.select_dep,
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF073590),
                                              ),
                                            ),
                                            Text(
                                              depAirportCode,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF073590),
                                                
                                              ),
                                            ),
                                              ],
                                            ),
                                          
                                        ],
                                      )
                                    ),
                                    const Divider(
                                      height: 1.0,
                                      thickness: 1,
                                      color: Color.fromARGB(132, 158, 158, 158),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const ArrivalAutoPage(valDest: 'roundtrip'),
                                            ),
                                             );
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Text(
                                                  AppLocalizations.of(context)!.to,
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                checkedValue ? AppLocalizations.of(context)!.anywhere : DepAirport.getDestAirport() ?? AppLocalizations.of(context)!.select_dest,
                                                style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF073590),
                                              ),
                                              ),
                                              Text(
                                                checkedValue ? '' : destAirportCode,
                                                style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF073590),
                                                
                                              ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              
                            ),
                                Column(
                              children: [Column(
                                children: [
                                  Transform.rotate(
                                    angle: -math.pi / 2,
                                    child: IconButton(
                                      icon: Icon(Icons.compare_arrows_rounded),
                                      onPressed: () {

                                        if(DepAirport.getDepAirport() == null || DepAirport.getDestAirport() == null){
                                          return;
                                        }

                                        DepAirport.setairportTempName(DepAirport.getDestAirport()!);
                                        DepAirport.setairportTempCode(DepAirport.getDestAirportCode()!);

                                        setState(() {
                                          

                                        //DEp to Dest

                                        DepAirport.setDestAirport(DepAirport.getDepAirport()!);
                                        DepAirport.setDestAirportCode(DepAirport.getDepAirportCode()!);

                                        DepAirport.setDepAirport(DepAirport.getairportTempName()!);
                                        DepAirport.setDepAirportCode(DepAirport.getairportTempCode()!);

                                        depAirportName = DepAirport.getDepAirport()!;
                                        depAirportCode = DepAirport.getDepAirportCode()!;
                                        destAirportName = DepAirport.getDestAirport()!;
                                        destAirportCode = DepAirport.getDestAirportCode()!;

                                        });

                                      },
                                    ),
                                  ),
                                  
                                ],
                              ),
                              ],
                              ),
                              ],
                            ),
                            Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: Checkbox(
                                      value: checkedValue,
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        
                                      ),
                                      activeColor: Color.fromRGBO(246, 137, 21,1),
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          checkedValue = newValue!;
                                        });
                                      },
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
                                    ),
                                ),
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.anywhere,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                          ],
                        ),
                        
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                       elevation: 5,
                       child: checkedValue ? DateAnywhere(tripType: 'roundtrip') : DateRangePickerWidget(tripType: 'roundtrip'),
                            
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(241, 201, 51, 1)),
                    ),
                    onPressed: () {
    
                      //If no Destination selected
    
                      if(!checkedValue && DepAirport.getDestAirportCode() == null){
    
                          showDialog(
                            context: context,
                            builder: (context){
                              return SelectDestination();
                          }
                        );
                        return;
                      }
                      //If no dates selected
                      if(DepAirport.getFromDateSelected() == null || DepAirport.getToDateSelected() == null){
                        showDialog(
                            context: context,
                            builder: (context){
                              return SelectDates();
                          }
                        );
                        return;
                      }
                      if(DepAirport.getdurationFrom() == null){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${AppLocalizations.of(context)!.alert_days_dest_round}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(246, 137, 21,1)),
                                      ),
                                      onPressed: () => Navigator.pop(context, 'Ok'),
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        );
                        return;

                      }
                      if(!checkedValue){
                      Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RoundTripResults(),
                                    ),
                                     );
                      }

                      if(checkedValue){
                     

                        Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RoundTripAnywhereResults(),
                                    ),
                                     );


                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.one_way_btn_search,
                      style: TextStyle(
                        color: Color.fromRGBO(7, 53, 144, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                                DepAirport.removeValueDestName();
                                DepAirport.removeValueDestCode();
                                DepAirport.removeDateFromSelected();
                                DepAirport.removeDateToSelected();
                      
                                Navigator.popAndPushNamed(context, '/homeRyanair');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_outlined,
                                    size: 20.0,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.back_btn,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
      ),
      

    );
  }
}