import 'package:flutter/material.dart';
import 'package:flutter_app/currency.dart';
import 'package:flutter_app/requests.dart';

class CryptoDetailWidget extends StatelessWidget {
  CryptoDetailWidget({this.id});

  final String id;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: new Text(this.id),
      ),




      body: new SafeArea( //needed ?
        child: new Container(
          alignment: FractionalOffset.center,
          color: Colors.white,
          margin: const EdgeInsets.all(8.0),
          child: new Card(
              color: Colors.lightGreen,
              child: _detail()
          ),
        ),
      ) ,


      /*body: new Center(
        child:
        new RaisedButton(onPressed: () {
          Navigator.pop(context);
        },
          child:
          new FutureBuilder<Currency>(
            future: getcurrency(this.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Text(snapshot.data.name);
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),*/
    );
  }

  FutureBuilder<Currency> _detail() {
      return new FutureBuilder<Currency>(
        future: getcurrency(this.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new Text(snapshot.data.name);
          }
        },
    );
  }
}