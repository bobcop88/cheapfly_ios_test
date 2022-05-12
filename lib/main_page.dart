import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ryanairapp/utils/depairport.dart';

import 'package:ryanairapp/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Main_Page extends StatefulWidget {
  const Main_Page({ Key? key }) : super(key: key);

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {

  bool hasInternet = false;



  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(246, 137, 21,1),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: 
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                      'CheapFly - '
                    ),
                    Text(
                      AppLocalizations.of(context)!.title_mainpage,
                    ),
                 ],
               ),
              
            
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Container(
                              height: 100.0,
                              child: Image.asset(
                                'assets/CheapFly.png',
                                fit: BoxFit.contain,
                                ),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.title1_mainpage,
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(246, 137, 21,1),
                                            ),
                                          ),
                                          // Text(
                                          //   'the Better!',
                                          //   style: TextStyle(
                                          //     fontSize: 25.0,
                                          //     fontWeight: FontWeight.bold,
                                          //     color: Color.fromRGBO(32, 145, 235,1),
                                          //   ),
                                          // ),
                                        ],
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 5,
                        color: Color.fromRGBO(7, 53, 144, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            children: [
                              Text(
                                'RYANAIR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.sub_ryanair_mainpage,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ElevatedButton(
                                  onPressed: () async{
                                    hasInternet = await InternetConnectionChecker().hasConnection;

                                      if(hasInternet){
                                        Navigator.pushReplacementNamed(context, '/homeRyanair');
                                        // DepAirport.setlocale_lang_user(Localizations.localeOf(context).languageCode);
                                        // DepAirport.setlocale_country_user(Localizations.localeOf(context).languageCode);

                                        if(Localizations.localeOf(context).languageCode == 'it'){
                                          DepAirport.setlocale_lang_user('it');
                                          DepAirport.setlocale_country_user('it');
                                        }else if(Localizations.localeOf(context).languageCode == 'es'){
                                          DepAirport.setlocale_lang_user('es');
                                          DepAirport.setlocale_country_user('es');
                                        }else{
                                          DepAirport.setlocale_lang_user('en');
                                          DepAirport.setlocale_country_user('ie');
                                        }






                                        
                                      }else{
                                        showDialog(
                                          context: context,
                                          builder: (context) => 
                                          NoInternet(),
                                       
                                          );
                                      }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(241, 201, 51, 1)),
                                    
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.search_btn_mainpage,
                                    style: TextStyle(
                                      color: Color.fromRGBO(7, 53, 144, 1)
                                    ),
                                  ),
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
             
              
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
                      child: Image.asset(
                        'assets/logo_dev2.png'
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(
                        AppLocalizations.of(context)!.developed_mainpage
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.disclaimer_mainpage,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
        
      ),
    );
  }


  Future<bool> onWillPop() async {

    final shouldPop = await showDialog(
        context: context,
        builder: (context) =>
        AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you leaving now?'
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(246, 137, 21,1)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

        )
      );



    return shouldPop ?? false;
  }
}