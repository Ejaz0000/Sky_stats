import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sky_stat/Api/getloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }

  void getcity() async{
    Position position = await _determinePosition();
    getloc loc = getloc();
    await loc.GetAddressFromLatLong(position);
    var location = loc.Address;
    Navigator.pushNamed(context, "/loading", arguments: {
    "searchText": location,
    });

  }

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)?.settings?.arguments as Map;
    var temp = info["temp_value"];
    var icon_value = info["icon_value"];
    var city = info["city_value"];
    var hum = info["hum_value"];
    var air = info["air_value"];
    var des = info["des_value"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade800, Colors.blue.shade300])),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(24, 20, 10, 20),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(searchController.text == "") {
                               print("Blank search");
                              }else {
                                Navigator.pushNamed(context, "/loading", arguments: {
                                  "searchText": searchController.text,
                                });
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                )),
                          ),
                          Expanded(
                              child: TextField(
                                controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search any city"),
                          )),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10,0, 24, 0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () {
                        getcity();
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Image.network("http:$icon_value", height: 100,width: 100,),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text(
                                "$des",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$city",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.all(28),
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$temp",style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.normal
                              ),),
                              Text("C",style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(28),
                      margin: EdgeInsets.fromLTRB(24, 0, 10, 0),
                      height: 190,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.day_windy)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text("$air",style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),),
                          Text("km/h",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(28),
                      margin: EdgeInsets.fromLTRB(5, 0, 26, 0),
                      height: 190,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text("$hum",style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("%",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal
                          ),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text("Created by me"),
                    Text("Data Provided by weatherapi.com"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
