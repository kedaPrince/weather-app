import 'dart:ui';

import '../constants/colors.dart';

class WeatherUtils {
  // Existing code...

  static Map<String, dynamic> getBackgroundInfo(String? description) {
    if (description == 'clear sky') {
      return {
        'backgroundColor': AppColors.sunnyColor,
        'backgroundImage': 'assets/images/backgrounds/forest_sunny.png',
      };
    } else if (description == 'few clouds' ||
        description == 'broken clouds' ||
        description == 'scattered clouds') {
      return {
        'backgroundColor': AppColors.cloudyColor,
        'backgroundImage': 'assets/images/backgrounds/forest_cloudy.png',
      };
    } else if (description == 'light rain' || description == 'overcast clouds') {
      return {
        'backgroundColor': AppColors.rainColor,
        'backgroundImage': 'assets/images/backgrounds/forest_rainy.png',
      };
    } else {
      // Default background if no match found
      return {
        'backgroundColor': AppColors.mainColor,
        'backgroundImage': 'assets/images/backgrounds/forest_rainy.png',
      };
    }
  }

  static String getWeatherIcon(String weatherDescription) {
    return '${weatherDescription.replaceAll('', '').toLowerCase()}.png';
  }

}
