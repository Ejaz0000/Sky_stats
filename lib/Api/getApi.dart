import 'package:http/http.dart';
import 'dart:convert';

class getapi
{
  late String location;
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String icon;

  getapi({location}){
    this.location = location;
  }

  Future <void> getData() async
  {
    try{Response response = await get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=b255bcfa5bc8474c814135632231509&q=$location"));
    Map data =jsonDecode(response.body);

    Map current_data = data["current"];
    temp = current_data["temp_c"].toString();

    humidity = current_data["humidity"].toString();

    air_speed = current_data["wind_kph"].toString();

    Map condition = current_data["condition"];

    description = condition["text"];
    icon = condition["icon"];


    } catch(e){
      temp = "No Data";
      humidity = "No Data";
      air_speed = "No Data";
      description = "No Data";
      icon = "No Data";
    }



  }

}