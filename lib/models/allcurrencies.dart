//json model- to get the body of the response and give me final map

// To parse this JSON data, do
//
//     final allCurrencies = allCurrenciesFromJson(jsonString);

import 'dart:convert';

Map<String, String> allCurrenciesFromJson(String str) =>
 Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String allCurrenciesToJson(Map<String, String> data) => 
 json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));


