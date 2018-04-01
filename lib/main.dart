import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  print("Hello world");

  List currencies = await getCurrencies();
  print(currencies);

  runApp(new MaterialApp(
    home: new CryptoListWidget(currencies),
  ));
}


Future<List> getCurrencies() async {
  String apiUrl = 'https://api.coinmarketcap.com/v1/ticker/?limit=50';
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

class CryptoListWidget extends StatelessWidget {
  // This is a list of material colors. Feel free to add more colors, it won't break the code
  final List<MaterialColor> _colors = [Colors.pink, Colors.pink, Colors.pink];
  // The underscore before a variable name marks it as a private variable
  final List _currencies;
  // This is a constructor in Dart. We are assigning the value passed to the constructor
  // to the _currencies variable
  CryptoListWidget(this._currencies);

  @override
  Widget build(BuildContext context) {
    // Build describes the widget in terms of other, lower-level widgets.
    return new Scaffold(
      body: _buildBody(),
      backgroundColor: Colors.blueGrey[300],
      floatingActionButton: new Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context)
          {
            return _snack(context);
          }),
    );
  }

  FloatingActionButton _snack (BuildContext context) {
    return new FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("Coming soon"),
                action: new SnackBarAction(
                    label: "UNDO",
                    onPressed: () => Scaffold.of(context).hideCurrentSnackBar())
            )
        );
      },
      child: new Icon(Icons.add_alert, color: Colors.pink[900]),
      backgroundColor: Colors.orange[400],

    );
  }

  Widget _buildBody() {
    return new Container(
      // A top margin of 56.0. A left and right margin of 8.0. And a bottom margin of 0.0.
      margin: const EdgeInsets.fromLTRB(8.0, 56.0, 8.0, 0.0),
      child: new Column(
        // A column widget can have several widgets that are placed in a top down fashion
        children: <Widget>[
          _getAppTitleWidget(),
          _getListViewWidget()
        ],
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Cryptocurrencies',
      style: new TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24.0
      ),
    );
  }

  Widget _getListViewWidget() {
    // We want the ListView to have the flexibility to expand to fill the
    // available space in the vertical axis
    return new Flexible(
        child: new ListView.builder(
          // The number of items to show
            itemCount: _currencies.length,
            // Callback that should return ListView children
            // The index parameter = 0...(itemCount-1)
            itemBuilder: (context, index) {
              // Get the currency at this position
              final Map currency = _currencies[index];


              // Get the icon color. Since x mod y, will always be less than y,
              // this will be within bounds
//              final MaterialColor color = _colors[index % _colors.length];
              final Color color = Colors.pink[900];
              return _getListItemWidget(currency, color);
            }
        )
    ) ;
  }

  CircleAvatar _getLeadingWidget(String currencyName, Color color) {
    return new CircleAvatar(
      backgroundColor: color,
      child: new Text(currencyName[0]),
    );
  }

  ListTile _getListTile(Map currency, Color color) {
    return new ListTile(
      leading: _getLeadingWidget(currency['name'], color),
      title: _getTitleWidget(currency['name']),
      subtitle: _getSubtitleWidget(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Container _getListItemWidget(Map currency, Color color) {
    // Returns a container widget that has a card child and a top margin of 5.0
    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: _getListTile(currency, color),
      ),
    );
  }

  Text _getTitleWidget(String currencyName) {
    return new Text(
      currencyName,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text _getSubtitleWidget(String priceUsd, String percentChange1h) {
    return new Text('\$$priceUsd\n1 hour: $percentChange1h%');
  }

}