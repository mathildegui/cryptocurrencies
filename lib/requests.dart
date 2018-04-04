import 'dart:async';
import 'dart:convert';
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