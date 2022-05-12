import 'dart:convert';
import 'package:flutter/material.dart';



List<Airport> postFromJson(String str) =>
    List<Airport>.from(json.decode(str).map((x) => Airport.fromMap(x)));

class Airport {
  Airport({
    required this.code,
    required this.name,
    
  });

  
  String code;
  String name;

  factory Airport.fromMap(Map<String, dynamic> json) => Airport(
        code: json['country']['code'],
        name: json['country']['name'],
        
      );
}




