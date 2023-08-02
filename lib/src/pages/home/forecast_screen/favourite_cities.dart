import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/constants/colors.dart';
import '../../../models/weather_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/background_utils.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/current_weather_widget.dart';
import '../../../widgets/favourite_city_widget.dart';
import '../../../widgets/min_current_max_widget.dart';
import '../../../widgets/small_text.dart';
import '../../../widgets/weather_app_icon_widget.dart';

class FavoriteListScreen extends StatefulWidget {

  final List<WeatherModel> cityList;
  const FavoriteListScreen({Key? key, required this.cityList})
      : super(key: key);

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  List<WeatherModel> get weatherData => widget.cityList;

  Map<String, dynamic> get backgroundInfo =>
      WeatherUtils.getBackgroundInfo(AppConstants.currentWeatherstatus);

  Color get backgroundColor => backgroundInfo['backgroundColor'];
  String get backgroundImage => backgroundInfo['backgroundImage'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    var weatherData = widget.cityList;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Favorite cities'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                print("Settings Tapped!");
              },
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          var cityData = weatherData[index];
          return FavouriteCityWidget(
            city: cityData.city,
            weatherData: cityData,
            icon: Image.asset(
              'assets/images/icons/${WeatherUtils.getWeatherIcon(cityData.description ?? '')}',
              width: 30,
            ),
            bigText: BigText(
              text: '${cityData.description ?? ''}°',
              color: Colors.white,
              size: 12,
            ),
            smallText: SmallText(
              text: '${cityData.temperature ?? ''}°',
              color: Colors.white,
              size: 24,
            ),
            onAddToFavorites: () {
              // Code to handle adding/removing from favorites if needed.
            },
          );
        },
      ),
    );
  }

// The rest of your code...
}

