import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ryanairapp/api/date_availability.dart';
import 'package:ryanairapp/utils/depairport.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ryanairapp/widgets/widgets.dart';




class DateRangePickerWidget extends StatefulWidget {

  final String tripType;

  const DateRangePickerWidget({ Key? key, required this.tripType }) : super(key: key);

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {

  final List<bool> isSelected = [false, false, false];


  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 5)) ,

  );

  

  String getFrom() {
    
    if(DepAirport.getFromDateSelected() == null){
      return AppLocalizations.of(context)!.from;
    }else{
      return  DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode).format(dateRange.start);
    }
  }



  String getUntil() {

    if(DepAirport.getToDateSelected() == null){
      return AppLocalizations.of(context)!.to;
    }else{
      return DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode).format(dateRange.end);
    }
  }


  @override
  Widget build(BuildContext context) {

    if(widget.tripType == 'oneway'){

    return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dates_title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300.0,
                              child: Text(
                                AppLocalizations.of(context)!.dates_sub_title,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 100,
                endIndent: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children:[ TextButton(
                      onPressed: () {

                        if(DepAirport.getDestAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }else{

                        pickDateRange.call();
                        }

                        },
                      child: Text(
                        getFrom(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    ]),
                    Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [TextButton(
                      onPressed: () {
                        if(DepAirport.getDestAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                               
                              }
                            );
                            return;
                        }
                        
                      pickDateRange.call();

                      },
                      child: Text(
                        getUntil(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    ]),
                  
                ],
               
              ),
            ],
          ),
          
        ),
    );


    }

  if(widget.tripType == 'roundtrip'){


    
    return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dates_title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300.0,
                              child: Text(
                                AppLocalizations.of(context)!.dates_sub_title,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children:[ TextButton(
                      onPressed: () {

                        if(DepAirport.getDestAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }else{

                        pickDateRange.call();
                        }

                        },
                      child: Text(
                        getFrom(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ]),
                    Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [
                      TextButton(
                      onPressed: () {
                        if(DepAirport.getDestAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }
                        
                      pickDateRange.call();

                      },
                      child: Text(
                        getUntil(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ]),
                  
                ],
               
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 100,
                endIndent: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.days_in_dest_roundtrip,
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          ),

                          ],
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleButtons(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.one_days,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.four_days,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.eight_days,
                              ),
                            ),

                          ],
                          renderBorder: true,
                          borderColor: Colors.white,
                          color: Color.fromRGBO(32, 145, 235,1),
                          selectedBorderColor: Color(0xFF073590),
                          selectedColor: Color.fromRGBO(32, 145, 235,1),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          fillColor: Colors.white,
                          constraints: BoxConstraints(
                            minWidth: 25.0,
                            minHeight: 20.0
                          ),
                          isSelected: isSelected,
                          // textStyle: TextStyle(
                          //   color: Color.fromRGBO(32, 145, 235,1),
                          // ),
                          onPressed: (int index) {
                            setState(() {

                              
                              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                  if(isSelected[0]){
                                    isSelected[1] = isSelected[2] = false;
                                    DepAirport.setDurationFrom(1.toString());
                                    DepAirport.setDurationTo(3.toString());
                                  }
                                  if(isSelected[1]){
                                    isSelected[0] = isSelected[2] = false;
                                    DepAirport.setDurationFrom(4.toString());
                                    DepAirport.setDurationTo(7.toString());
                                  }
                                  if(isSelected[2]){
                                    isSelected[1] = isSelected[0] = false;
                                    DepAirport.setDurationFrom(8.toString());
                                    DepAirport.setDurationTo(14.toString());
                                  }
                                  

                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                            });
                          },
                          
                        ),
                        
                        
                      ],
                    ),
 
                  ],
                ),
              ),
            ],
          );
          
        
    
  }else{

    return Container(
      child: Text(
        'Return'
      )
    );
  }




  }



  Future pickDateRange() async {

      
      DateTime getDateCorrect() {

        if(DateTime.now().isAfter(DateTime.parse(DepAirport.getFromDate()!))){

          return DateTime.now();
        }else{
          return DateTime.parse(DepAirport.getFromDate()!);
        }
      }

      

      
      

    final newDateRange = await showDateRangePicker(
      context: context,
      // initialDateRange: dateRange,
      firstDate:  getDateCorrect(),
      lastDate: DateTime.parse(DepAirport.getToDate()!),
      helpText: '${AppLocalizations.of(context)!.from.toLowerCase()} ${DepAirport.getDepAirport()} ${AppLocalizations.of(context)!.to.toLowerCase()} ${DepAirport.getDestAirport()}',
      saveText: AppLocalizations.of(context)!.dates_go_now,
      initialEntryMode:  DatePickerEntryMode.calendarOnly,
      builder: (context, child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(7, 53, 144, 1), // header background color
              onPrimary: Color.fromARGB(255, 247, 247, 247), // header text color
              onSurface: Colors.black, // body text color
              
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          child: child!
        );
        
      }
      

      );

      if(newDateRange == null) return;
      setState(() =>  {
        dateRange = newDateRange,
        DepAirport.setFromDateSelected(DateFormat('yyyy-MM-dd').format(dateRange.start)),
        DepAirport.setToDateSelected(DateFormat('yyyy-MM-dd').format(dateRange.end)),

        
        
        
        });

       
  }

}


class DateAnywhere extends StatefulWidget {

  final String tripType;
  const DateAnywhere({ Key? key, required this.tripType}) : super(key: key);

  @override
  State<DateAnywhere> createState() => _DateAnywhereState();
}

class _DateAnywhereState extends State<DateAnywhere> {

  final List<bool> isSelected = [false, false, false];

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 5)) ,

  );

  String getFrom() {
    
    if(DepAirport.getFromDateSelected() == null){
      return AppLocalizations.of(context)!.from;
    }else{
      return  DateFormat('dd MMMM yyyy',  Localizations.localeOf(context).languageCode).format(dateRange.start);
    }
  }



  String getUntil() {

    if(DepAirport.getToDateSelected() == null){
      return AppLocalizations.of(context)!.to;
    }else{
      return DateFormat('dd MMMM yyyy',  Localizations.localeOf(context).languageCode).format(dateRange.end);
    }
  }


  void _show() async {

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 365)),
      currentDate: DateTime.now(),
      helpText: '${AppLocalizations.of(context)!.from.toLowerCase()} ${DepAirport.getDepAirport()} ${AppLocalizations.of(context)!.to.toLowerCase()} ${AppLocalizations.of(context)!.anywhere}',
      saveText: AppLocalizations.of(context)!.dates_go_now,
      initialEntryMode:  DatePickerEntryMode.calendarOnly,
      builder: (context, child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(7, 53, 144, 1), // header background color
              onPrimary: Color.fromARGB(255, 247, 247, 247), // header text color
              onSurface: Colors.black, // body text color
              
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          child: child!
        );
        
      }

      );

      if(newDateRange == null) return;
      setState(() {
        dateRange = newDateRange;
        DepAirport.setFromDateSelected(DateFormat('yyyy-MM-dd').format(dateRange.start));
        DepAirport.setToDateSelected(DateFormat('yyyy-MM-dd').format(dateRange.end));
      });
  }

  @override
  Widget build(BuildContext context) {

    if(widget.tripType == 'oneway'){

    return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dates_title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300.0,
                              child: Text(
                                AppLocalizations.of(context)!.dates_sub_title,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 100,
                endIndent: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children:[ TextButton(
                      onPressed: () {

                        if(DepAirport.getDepAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }else{

                        _show.call();
                        }

                        },
                      child: Text(
                        getFrom(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    ]),
                    Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [TextButton(
                      onPressed: () {
                        if(DepAirport.getDepAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }
                        
                      _show.call();

                      },
                      child: Text(
                        getUntil(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    ]),
                  
                ],
               
              ),
            ],
          ),
          
        ),
    );
    }
    //end if

    if(widget.tripType == 'roundtrip'){
      return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dates_title,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 300.0,
                              child: Text(
                                AppLocalizations.of(context)!.dates_sub_title,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children:[ TextButton(
                      onPressed: () {

                        if(DepAirport.getDepAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }else{

                        _show.call();
                        }

                        },
                      child: Text(
                        getFrom(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ]),
                    Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  Column(
                    children: [
                      TextButton(
                      onPressed: () {
                        if(DepAirport.getDepAirportCode() == null){

                          showDialog(
                            context: context,
                            builder: (context){
                                  return SelectDestination();
                              }
                            );
                            return;
                        }
                        
                      _show.call();

                      },
                      child: Text(
                        getUntil(),
                        style: TextStyle(
                          color: Color(0xFF073590),
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    ]),
                  
                ],
               
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 100,
                endIndent: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.days_in_dest_roundtrip,
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          ),

                          ],
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleButtons(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.one_days,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.four_days,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.eight_days,
                              ),
                            ),

                          ],
                          renderBorder: true,
                          borderColor: Colors.white,
                          color: Color.fromRGBO(32, 145, 235,1),
                          selectedBorderColor: Color(0xFF073590),
                          selectedColor: Color.fromRGBO(32, 145, 235,1),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          fillColor: Colors.white,
                          constraints: BoxConstraints(
                            minWidth: 25.0,
                            minHeight: 20.0
                          ),
                          isSelected: isSelected,

                          onPressed: (int index) {
                             

                            
                            setState(() {

                              
                              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                  if(isSelected[0]){
                                    isSelected[1] = isSelected[2] = false;
                                    DepAirport.setDurationFrom(1.toString());
                                    DepAirport.setDurationTo(3.toString());
                                  }
                                  if(isSelected[1]){
                                    isSelected[0] = isSelected[2] = false;
                                    DepAirport.setDurationFrom(4.toString());
                                    DepAirport.setDurationTo(7.toString());
                                  }
                                  if(isSelected[2]){
                                    isSelected[1] = isSelected[0] = false;
                                    DepAirport.setDurationFrom(8.toString());
                                    DepAirport.setDurationTo(14.toString());
                                  }
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                            });
                            
                          },
                          
                        ),
                        
                        
                      ],
                    ),
 
                  ],
                ),
              ),
            ],
          );


    }else{

    return Container(
      child: Text(
        'Return'
      )
    );
  }

  }
}