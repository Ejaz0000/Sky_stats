import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sky_stat/Api/getApi.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city= "Dhaka";
  late String temp;
  late String hum;
  late String air;
  late String des;
  late String icon;


  void startApp(String city) async{
    getapi weath = getapi(location: "$city");
    await weath.getData();

    temp = weath.temp;
    hum = weath.humidity;
    air = weath.air_speed;
    des = weath.description;
    icon= weath.icon;
    Future.delayed(Duration(seconds: 2),(){
      if(temp == "No Data"){
        Navigator.pushReplacementNamed(context, '/location');
      }else {
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          "temp_value": temp,
          "hum_value": hum,
          "air_value": air,
          "des_value": des,
          "icon_value": icon,
          "city_value": city,
        });
      }
    });

  }






  @override
  void initState(){
    super.initState();
    print("initing");



  }

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)?.settings?.arguments != null){
       Map search = ModalRoute.of(context)?.settings?.arguments as Map;
       city = search["searchText"];
       startApp(city);
     }else{
     startApp(city);


    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            Image.asset("images/Sky_logo.png",height: 300,width: 350,),
          SizedBox(height: 100,),
          SpinKitThreeInOut(
            color: Colors.white60,
            size: 50.0,
          ),
            SizedBox(height: 100,),
            Text("Made by me",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),)
          ],
        ),
      ),
      backgroundColor: Colors.cyan[300],
    );
  }
}
