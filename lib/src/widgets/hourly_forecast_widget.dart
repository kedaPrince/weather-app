import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/constants/colors.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/utils/dimensions.dart';
import 'package:weather_app/src/widgets/big_text.dart';
import 'package:weather_app/src/widgets/small_text.dart';
import 'package:weather_app/src/widgets/weather_app_icon_widget.dart';

class HourlyForecastWidget extends StatelessWidget {
  final ForecastModel forecast;

  const HourlyForecastWidget({required this.forecast});

  @override
  Widget build(BuildContext context) {
    String forecastDescription =
        '${forecast.description!.replaceAll(' ', '').toLowerCase()}.png';
    String imagePath = 'assets/images/icons/$forecastDescription';

    return Center(
      child: Container(
        height: 120,
        width: 70,
        decoration: BoxDecoration(
          color: AppColors.mainBlackColor,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BigText(
              text: DateFormat('h a').format(forecast.date!),
              color: Colors.white,
              size: 18,
            ),
            WeatherAppIconWidget(
              icon: Image.asset(imagePath, width: 30),
              backgroundColor: AppColors.mainBlackColor,
            ),
            SmallText(
              text: '${forecast.temperature!.toInt()}\u00B0',
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
