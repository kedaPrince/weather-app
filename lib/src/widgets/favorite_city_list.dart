import 'package:flutter/material.dart';
import 'package:weather_app/src/widgets/small_text.dart';

import '../models/weather_model.dart';
import '../utils/background_utils.dart';
import 'big_text.dart';
import 'favourite_city_widget.dart';

class FavoriteCitiesList extends StatelessWidget {
  final List<WeatherModel> favoriteCitiesData;

  const FavoriteCitiesList({Key? key, required this.favoriteCitiesData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: favoriteCitiesData.map((weatherData) {
          return FavouriteCityWidget(
            city: weatherData.city,
            weatherData: weatherData,
            icon: Image.asset(
              'assets/images/icons/${WeatherUtils.getWeatherIcon(weatherData.description ?? '')}',
              width: 30,
            ),
            bigText: BigText(
              text: '${weatherData.description ?? ''}°',
              color: Colors.white,
              size: 12,
            ),
            smallText: SmallText(
              text: '${weatherData.temperature ?? ''}°',
              color: Colors.white,
              size: 24,
            ),
            onAddToFavorites: () {}, // Empty function since this widget is read-only
          );
        }).toList(),
      ),

      //include the list of cities here
    );
  }
}

