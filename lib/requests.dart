import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/currency.dart';
import 'package:http/http.dart' as http;


Future<List> getCurrencies() async {
//  String apiUrl = 'https://api.coinmarketcap.com/v2/ticker/';
  String apiUrl = 'https://api.coinmarketcap.com/v2/listings/';
  // Make a HTTP GET request to the CoinMarketCap API.
  // Await basically pauses execution until the get() function returns a Response
  try {
    http.Response response = await http.get(apiUrl);

    JsonCodec codec = new JsonCodec();
    Map<String, dynamic> decoded = codec.decode(response.body);
    return decoded["data"];
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<Currency> getcurrency(String id) async {
  String apiUrl = 'https://api.coinmarketcap.com/v2/ticker/$id';

  try {
    final response = await http.get(apiUrl);

    //final items = (response as List).map((i) => new Currency.fromJson(i));


    final data = json.decode(response.body);
    print(data["data"]);
    return new Currency.fromJson(data["data"]);
  } catch (e) {
    print(e.toString());
  }
  return null;
}