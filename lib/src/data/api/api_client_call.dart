import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/weather_model.dart';
import '../../utils/app_constants.dart';


class ApiClientCall {
  Future<WeatherModel> getDataForWeather(String location) async {
    try {
      var apiKey = '388ed22078fd8df6195f43012cb146d1';
      var BASE_URL = 'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric';

      var baseResponseUrl = await http.get(Uri.parse(BASE_URL));
      if (baseResponseUrl.statusCode == 200) {
        final weatherData =
        Map<String, dynamic>.from(jsonDecode(baseResponseUrl.body) ?? {});
        return WeatherModel.fromJson(weatherData);
      } else {
        // Return a default WeatherModel object when the response is not successful
        return defaultWeatherModel();
      }
    } catch (e) {
      // Handle any other unexpected errors
      throw Exception('Failed to load weather data: $e');
    }
  }

  // Replace this method with your actual default WeatherModel constructor or factory
  WeatherModel defaultWeatherModel() {
    return WeatherModel(city: 'Unknown', temperature: 0,);
  }
}





