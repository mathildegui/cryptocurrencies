import 'package:flutter/material.dart';
import 'package:flutter_app/crypto_detail.dart';


class CryptoListWidget extends StatelessWidget {
  final List _currencies;

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
          builder: (BuildContext context) {
            return _snack(context);
          }),
    );
  }

  FloatingActionButton _snack(BuildContext context) {
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
          _getListViewWidget(),
        ],
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: const Text(
          'Cryptocurrencies',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ));
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
              final Color color = Colors.pink[900];
              return _getListItemWidget(currency, color, context);
            }
        )
    );
  }

  CircleAvatar _getLeadingWidget(String currencyName, Color color) {
    return new CircleAvatar(
      backgroundColor: color,
      child: new Text(currencyName[0]),
    );
  }

  ListTile _getListTile(Map currency, Color color, BuildContext context) {
    return new ListTile(
      leading: _getLeadingWidget(currency['name'], color),
      title: _getTitleWidget(currency['name']),
      subtitle: _getSubtitleWidget(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new CryptoDetailWidget(id : currency['id'])),
        );
      },
    );
  }

  Container _getListItemWidget(Map currency, Color color,
      BuildContext context) {
    // Returns a container widget that has a card child and a top margin of 5.0
    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: _getListTile(currency, color, context),
      ),
    );
  }

  Text _getTitleWidget(String currencyName) {
    return new Text(
      currencyName,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  RichText _getSubtitleWidget(String priceUsd, String percentChange1h) {
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUsd\n", style:
    new TextStyle(color: Colors.black));

    String percentChangeText = "1 hour: $percentChange1h%";
    TextSpan percentChangeTextWidget;

    if (double.parse(percentChange1h) > 0) {
      //currency price decreased. Color percent change text green
      percentChangeTextWidget = new TextSpan(text: percentChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      //currency price decreased. Color percent change text red
      percentChangeTextWidget = new TextSpan(text: percentChangeText,
          style: new TextStyle(color: Colors.red));
    }

    return new RichText(text: new TextSpan(
        children: [
          priceTextWidget,
          percentChangeTextWidget
        ]
    ));
  }
}