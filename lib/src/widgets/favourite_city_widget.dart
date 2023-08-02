import 'package:flutter/material.dart';
import 'package:weather_app/src/utils/app_constants.dart';
import 'package:weather_app/src/widgets/big_text.dart';
import 'package:weather_app/src/widgets/day_type_widget.dart';
import 'package:weather_app/src/widgets/small_text.dart';
import 'package:weather_app/src/widgets/weather_app_icon_widget.dart';

import '../constants/colors.dart';
import '../models/weather_model.dart';
import '../utils/dimensions.dart';

class FavouriteCityWidget extends StatelessWidget {
  final String city;
  final BigText bigText;
  final Image icon;
  final SmallText smallText;
  final WeatherModel weatherData;
  final VoidCallback onAddToFavorites; // Add the onAddToFavorites parameter

  const FavouriteCityWidget({
    Key? key,
    required this.city,
    required this.bigText,
    required this.icon,
    required this.smallText,
    required this.weatherData,
    required this.onAddToFavorites, // Add the onAddToFavorites parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String description = weatherData.description ?? 'clear';
    final double temperature = weatherData.temperature ?? 0.0;

    // Get the weather icon description and construct the image path
    final String forecastDescription =
        '${description.replaceAll(' ', '').toLowerCase()}.png';
    final String imagePath = 'assets/images/icons/$forecastDescription';

    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20),
      child: GestureDetector(
        onTap: onAddToFavorites,
        child: Container(
          height: Dimensions.height45,
          width: Dimensions.width20 * 10,
          decoration: BoxDecoration(
            color: AppColors.mainBlackColor,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WeatherAppIconWidget(
                icon: Image.asset(imagePath, width: 30),
                backgroundColor: AppColors.mainBlackColor,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(text: city, color: Colors.white, size: 12),
                  DayTypeText(text: '$description\u00B0', color: Colors.white, size: 14),
                ],
              ),
              SmallText(text: '${temperature.toInt()}\u00B0', color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
