import 'package:flutter/material.dart';
import 'package:flutter_app/currency.dart';
import 'package:flutter_app/requests.dart';

class CryptoDetailWidget extends StatelessWidget {
  CryptoDetailWidget({this.id });

  final String id;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: new Text("Second Screen"),
      ),
      body: new Center(
        /*child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(this.id),
        ),*/

        child:

        new RaisedButton(onPressed: () {
          Navigator.pop(context);
        },
          child:
          new FutureBuilder<Currency>(
            future: getcurrency(this.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Text(this.id);
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}