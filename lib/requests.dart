import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/currency.dart';
import 'package:http/http.dart' as http;


Future<List> getCurrencies() async {
  String apiUrl = 'https://api.coinmarketcap.com/v1/ticker/';
  // Make a HTTP GET request to the CoinMarketCap API.
  // Await basically pauses execution until the get() function returns a Response
  try {
    http.Response response = await http.get(apiUrl);

    JsonCodec codec = new JsonCodec();
    return codec.decode(response.body);
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<Currency> getcurrency(String id) async {
  String apiUrl = 'https://api.coinmarketcap.com/v1/ticker/$id';

  try {
    final response = await http.get(apiUrl);

    //final items = (response as List).map((i) => new Currency.fromJson(i));


    final data = json.decode(response.body);
    print(data[0]);
    return new Currency.fromJson(data[0]);
  } catch (e) {
    print(e.toString());
  }
  return null;
}