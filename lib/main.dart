import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    title: 'Weather App',
    home: Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  var url = "https://api.openweathermap.org/data/2.5/weather?q=Duzce&units=metric&appid=351f6f012c85e4d8fbd878e3fcc6304a";
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather () async {
    http.Response response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);
    setState((){
      this.temp           = results['main']['temp'];
      this.description    = results['weather'][0]['description'];
      this.currently      = results['weather'][0]['main'];
      this.humidity       = results['main']['humidity'];
      this.windSpeed      = results['wind']['speed'];
    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Şu an da Düzce'de",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Yükleniyor...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Yükleniyor...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Sıcaklık"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Yükleniyor..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Hava Durumu"),
                    trailing: Text(description != null ? description.toString() : "Yükleniyor..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Sıcaklık Nem Oranı"),
                    trailing: Text(humidity != null ? humidity.toString() : "Yükleniyor..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Rüzgar Hızı"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Yükleniyor..."),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}