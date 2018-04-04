import 'package:flutter/material.dart';
import 'requests.dart';
import 'crypto.dart';

void main() async {
  List currencies = await getCurrencies();
  print(currencies);

  runApp(new MaterialApp(
    home: new CryptoListWidget(currencies),
  ));
}

