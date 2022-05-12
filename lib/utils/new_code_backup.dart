
//   late Future<FaresResults> faresResults;


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     faresResults = fetchFaresResults('https://www.ryanair.com/api/farfnd/3/oneWayFares?=&departureAirportIataCode=PFO&language=en&limit=16&market=en-gb&offset=0&outboundDepartureDateFrom=2022-05-01&outboundDepartureDateTo=2023-05-01&priceValueTo=150');
//   }

//  Container(
//                 // height: 250.0,
//                         child: FutureBuilder<FaresResults>(
//                           future: faresResults,
//                           builder: (context, snapshot){
//                             if(snapshot.hasData){
//                               return Expanded(
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.vertical,
//                                   shrinkWrap: true,
//                                   itemCount: snapshot.data!.faresResults.length,
//                                   itemBuilder: (context, index) {
//                                     return SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             '${snapshot.data!.faresResults[index].departureAirportName}'
//                                           ),
//                                           Text(
//                                             '${snapshot.data!.faresResults[index].departureAirportCode}'
//                                           ),
//                                           Text(
//                                             '${snapshot.data!.faresResults[index].arrivalAirportName}'
//                                           ),
//                                           Text(
//                                             '${snapshot.data!.faresResults[index].arrivalAirportCode}'
//                                           ),
//                                           Text(
//                                             '${snapshot.data!.faresResults[index].flightNumber}'
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }, 
//                                 ),
//                               );
//                             }else if(snapshot.hasError){
//                               return Text('Error');
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),


// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Expanded(
//       child: CheckboxListTile(
//         contentPadding: EdgeInsets.zero,
//         title: Text('Anywhere'),
//         value: true,
//         onChanged: (newValue) {},
//         controlAffinity: ListTileControlAffinity.leading,
    
    
//       ),
//     ),
//   ],
// ),


// Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                             SizedBox(
//                               height: 20.0,
//                               width: 20.0,
//                               child: Checkbox(
//                                   value: true,
//                                   onChanged: (newValue) {},
//                                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap
//                                 ),
//                             ),
//                               Text(
//                                 'Anywhere'
//                               ),
//                       ],
//                     ),