class AppConstants {
  static const String APP_NAME = 'weatherApp';
  static const int APP_VESRION =1;

  static const String apiKey = '388ed22078fd8df6195f43012cb146d1';
  static String BASE_URL = 'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric';
  static const String TOKEN ='';


  static  String location ='Johannesburg';
  static double? temperature;
  static double? windSpeed;
  static double? humidity;
  static double? cloud;
  static  String currentDate = '';
  static  String currentWeatherstatus ='';
  static int pressure = 0;
  static double? temp_min;
  static double? temp_max;





  static String weatherIcon = 'assets/images/icons/rain@2x.png';
}