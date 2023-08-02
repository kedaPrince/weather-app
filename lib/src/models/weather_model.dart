class WeatherModel {
  String city;
  double? temperature;
  double? windSpeed;
  int? humidity;
  //int? pressure;
  DateTime? date;
  String? description;
  double? cloud;
  double? temp_min;
  double? temp_max;
  List<ForecastModel>? forecastList;


  WeatherModel({
    required this.city,
    this.temperature,
    this.windSpeed,
    this.humidity,
    //this.pressure,
    this.date,
    this.description,
    this.cloud,
    this.temp_min,
    this.temp_max,
    this.forecastList,


  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    var firstEntry = json['list'][0];
    return WeatherModel(
      city: json['city']['name'],
      temperature: firstEntry['main']['temp'].toDouble(), // Explicitly cast to double
      windSpeed: firstEntry['wind']['speed'].toDouble(), // Explicitly cast to double
      humidity: firstEntry['main']['humidity'],
      date: DateTime.parse(firstEntry['dt_txt']),
      description: firstEntry['weather'][0]['description'],
      cloud: firstEntry['clouds']['all'].toDouble(), // Explicitly cast to double
      forecastList: _parseForecastData(json['list']),
      temp_min: firstEntry['main']['temp_min'],
      temp_max: firstEntry['main']['temp_max']
    );
  }


  static List<ForecastModel> _parseForecastData(List<dynamic> list) {
    // Parse the forecast data for the list of forecasts
    List<ForecastModel> forecastData = [];
    for (var entry in list) {
      forecastData.add(ForecastModel.fromJson(entry));
    }
    return forecastData;
  }
}

class ForecastModel {
  double? temperature;
  DateTime? date;
  String? description;

  ForecastModel({this.temperature, this.date, this.description});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      temperature: json['main']['temp'].toDouble(), // Explicitly cast to double
      date: DateTime.parse(json['dt_txt']),
      description: json['weather'][0]['description'],
    );
  }
  WeatherModel createFavoriteCityModel(WeatherModel weatherData) {
    return WeatherModel(
      city: weatherData.city,
      temperature: weatherData.temperature,
      windSpeed: weatherData.windSpeed,
      humidity: weatherData.humidity,
      date: weatherData.date,
      description: weatherData.description,
      cloud: weatherData.cloud,
      temp_min: weatherData.temp_min,
      temp_max: weatherData.temp_max,
      forecastList: weatherData.forecastList,
    );
  }

}
