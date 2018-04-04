import 'package:flutter/material.dart';

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
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(this.id),
        ),
      ),
    );
  }
}