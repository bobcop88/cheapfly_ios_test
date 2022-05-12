import 'package:flutter/material.dart';
import 'package:ryanairapp/onway.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'dart:math' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NoInternet extends StatefulWidget {
  const NoInternet({ Key? key }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                    title: 
                        Column(
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              size: 30.0,
                              color: Color.fromRGBO(7, 53, 144, 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                AppLocalizations.of(context)!.no_internet,
                              ),
                            ),
                          ],
                        ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Expanded(
                                child: Text(
                                    AppLocalizations.of(context)!.no_internet_sub_title,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                  ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    elevation: 5,
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],

                  );
  }
}

class NoFlights extends StatefulWidget {

  final String backPage;
  const NoFlights({ Key? key, required this.backPage }) : super(key: key);

  @override
  State<NoFlights> createState() => _NoFlightsState();
}

class _NoFlightsState extends State<NoFlights> {
  @override
  Widget build(BuildContext context) {
    return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Transform.rotate(
                                          angle: math.pi/2,
                                          child: Icon(
                                            Icons.airplanemode_inactive_rounded,
                                            size: 30.0,
                                            color: Colors.red,
                                            ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Oops...',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Text(
                                          AppLocalizations.of(context)!.no_flights_title,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400,
                                            
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: Text(
                                            AppLocalizations.of(context)!.no_flights_sub_title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                              
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: ElevatedButton(
                                          child: Text(
                                            AppLocalizations.of(context)!.change_dates,
                                          ),
                                          onPressed: () {
                                            DepAirport.removeDateFromSelected();
                                            DepAirport.removeDateToSelected();
                                            Navigator.popAndPushNamed(context, widget.backPage);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                            ),
                          ],
                        );
  }
}



class NoAirportFound extends StatefulWidget {
  const NoAirportFound({ Key? key }) : super(key: key);

  @override
  State<NoAirportFound> createState() => _NoAirportFoundState();
}

class _NoAirportFoundState extends State<NoAirportFound> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: Text(
                AppLocalizations.of(context)!.no_airport_found,
                
              ),
            );
  }
}

class SelectDestination extends StatefulWidget {
  const SelectDestination({ Key? key }) : super(key: key);

  @override
  State<SelectDestination> createState() => _SelectDestinationState();
}

class _SelectDestinationState extends State<SelectDestination> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.select_destination_error,
                textAlign: TextAlign.center,
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
}

class SelectDates extends StatefulWidget {
  const SelectDates({ Key? key }) : super(key: key);

  @override
  State<SelectDates> createState() => _SelectDatesState();
}

class _SelectDatesState extends State<SelectDates> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.select_dates_error,
                      textAlign: TextAlign.center,
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
}

class CircularProgression extends StatefulWidget {
  const CircularProgression({ Key? key }) : super(key: key);

  @override
  State<CircularProgression> createState() => _CircularProgressionState();
}

class _CircularProgressionState extends State<CircularProgression> {
  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                ],
              ),
            ],
          );
  }
}