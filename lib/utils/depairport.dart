import 'package:shared_preferences/shared_preferences.dart';


class DepAirport{

  static SharedPreferences? _preferences;


  //Dep Airport Name Store

  static const _depAirport = 'depAirportName1';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();


  static Future setDepAirport(String depAirport) async {
    await _preferences?.setString(_depAirport, depAirport);
  }

  static String? getDepAirport() => _preferences?.getString(_depAirport);

  //Remove Dep Airport Name
  static Future removeValueDepName() async {
    await _preferences?.remove(_depAirportCode);
  }


  //Dep Airport Code Store

  static const _depAirportCode = 'depAirportCode1';

  static Future setDepAirportCode(String depAirportCode) async{
    await _preferences?.setString(_depAirportCode, depAirportCode);
  }

  static String? getDepAirportCode() => _preferences?.getString(_depAirportCode);

  //Remove Dep Airport Code
  static Future removeValueDepCode() async {
    await _preferences?.remove(_depAirportCode);
  }


  //Dest Airport Name Store
  static const _destAirport = 'destAirportName1';

  static Future setDestAirport(String destAirport) async {
    await _preferences?.setString(_destAirport, destAirport);
  }

  static String? getDestAirport() => _preferences?.getString(_destAirport);

  //Remove Dest Airport Name

  static Future removeValueDestName() async {
    await _preferences?.remove(_destAirport);
  }

  //Dest Airport Code Store

  static const _destAirportCode = 'destAirportCode1';

  static Future setDestAirportCode(String destAirportCode) async{
    await _preferences?.setString(_destAirportCode, destAirportCode);
  }

  static String? getDestAirportCode() => _preferences?.getString(_destAirportCode);

  //Remove Dest Airport Code

  static Future removeValueDestCode() async {
    await _preferences?.remove(_destAirportCode);
  }

  //Temp Store Airport Reverse Dep-Dest

  static const _airportTemp = 'airportTemp1';

  static Future setairportTempName(String airportTemp) async{
    await _preferences?.setString(_airportTemp, airportTemp);
  }

  static String? getairportTempName() => _preferences?.getString(_airportTemp);

  //Remove Temp Airport Name

  static Future removeValueAirportTempName() async {
    await _preferences?.remove(_airportTemp);
  }

  //Temp Airport Code
  static const _airportTempCode = 'airportTempCode1';

  static Future setairportTempCode(String airportTempCode) async{
    await _preferences?.setString(_airportTempCode, airportTempCode);
  }

  static String? getairportTempCode() => _preferences?.getString(_airportTempCode);

  //Remove temp Airport Code

  static Future removeValueAirportTempCode() async {
    await _preferences?.remove(_airportTempCode);
  }




  //Dates Search Api

  //From

  static const _fromDate = 'fromDate1';

  static Future setFromDate(String fromDate) async{
    await _preferences?.setString(_fromDate, fromDate);
  }

  static String? getFromDate() => _preferences?.getString(_fromDate);

  static Future removeDateFrom() async {
    await _preferences?.remove(_fromDate);
  }

  //To
  
  static const _toDate = 'toDate1';

  static Future setToDate(String toDate) async{
    await _preferences?.setString(_toDate, toDate);
  }

  static String? getToDate() => _preferences?.getString(_toDate);

  static Future removeDateTo() async {
    await _preferences?.remove(_toDate);
  }


  //Dates Selected User

  //From

  static const _fromDateSelected = 'fromDateSelected1';

  static Future setFromDateSelected(String fromDateSelected) async{
    await _preferences?.setString(_fromDateSelected, fromDateSelected);
  }

  static String? getFromDateSelected() => _preferences?.getString(_fromDateSelected);

  static Future removeDateFromSelected() async {
    await _preferences?.remove(_fromDateSelected);
  }


  //To

  static const _toDateSelected = 'toDateSelected1';

  static Future setToDateSelected(String toDateSelected) async{
    await _preferences?.setString(_toDateSelected, toDateSelected);
  }

  static String? getToDateSelected() => _preferences?.getString(_toDateSelected);

  static Future removeDateToSelected() async {
    await _preferences?.remove(_toDateSelected);
  }


  //Result flights
  static const _resultDate = 'resultDate1';

  static Future setResultDate(String resultDate) async{
    await _preferences?.setString(_resultDate, resultDate);
  }

  static String? getResultDate() => _preferences?.getString(_resultDate);

  static Future removeResultDate() async {
    await _preferences?.remove(_resultDate);
  }

  //Duration Roundtrip flights


  static const _durationFrom = 'durationFrom1';

  static Future setDurationFrom(String durationFrom) async{
    await _preferences?.setString(_durationFrom, durationFrom);
  }

  static String? getdurationFrom() => _preferences?.getString(_durationFrom);

  static Future removedurationFrom() async {
    await _preferences?.remove(_durationFrom);
  }


  static const _durationTo = 'durationTo1';

  static Future setDurationTo(String durationTo) async{
    await _preferences?.setString(_durationTo, durationTo);
  }

  static String? getdurationTo() => _preferences?.getString(_durationTo);

  static Future removedurationTo() async {
    await _preferences?.remove(_durationTo);
  }



  static const _resultDateInbound = 'resultDateInbound1';

  static Future setResultDateInbound(String resultDateInbound) async{
    await _preferences?.setString(_resultDateInbound, resultDateInbound);
  }

  static String? getResultDateInbound() => _preferences?.getString(_resultDateInbound);

  static Future removeResultDateInbound() async {
    await _preferences?.remove(_resultDateInbound);
  }

  static const _resultDateOutbound = 'resultDateOutbound1';

  static Future setResultDateOutbound(String resultDateOutbound) async{
    await _preferences?.setString(_resultDateOutbound, resultDateOutbound);
  }

  static String? getResultDateOutbound() => _preferences?.getString(_resultDateOutbound);

  static Future removeResultDateOutbound() async {
    await _preferences?.remove(_resultDateOutbound);
  }


  static const _locale_lang_user = 'locale_lang_user1';

  static Future setlocale_lang_user(String locale_lang_user) async{
    await _preferences?.setString(_locale_lang_user, locale_lang_user);
  }

  static String? getlocale_lang_user() => _preferences?.getString(_locale_lang_user);

  static Future removelocale_lang_user() async {
    await _preferences?.remove(_locale_lang_user);
  }

  static const _locale_country_user = 'locale_country_user1';

  static Future setlocale_country_user(String locale_country_user) async{
    await _preferences?.setString(_locale_country_user, locale_country_user);
  }

  static String? getlocale_country_user() => _preferences?.getString(_locale_country_user);

  static Future removelocale_country_user() async {
    await _preferences?.remove(_locale_country_user);
  }



}