import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather_app/src/constants/colors.dart';
import 'package:weather_app/src/utils/app_constants.dart';
import 'package:weather_app/src/utils/dimensions.dart';
import 'package:weather_app/src/widgets/big_text.dart';
import 'package:weather_app/src/widgets/day_type_widget.dart';
import 'package:weather_app/src/widgets/hourly_forecast_widget.dart';
import 'package:weather_app/src/widgets/min_current_max_widget.dart';
import 'package:weather_app/src/widgets/small_text.dart';
import '../../data/api/api_client_call.dart';
import '../../models/weather_model.dart';
import '../../utils/background_utils.dart';
import '../../utils/dialog_utils.dart';
import '../../widgets/current_weather_widget.dart';
import '../../widgets/favorite_city_list.dart';
import '../../widgets/favourite_city_widget.dart';
import 'forecast_screen/favourite_cities.dart';
import 'forecast_screen/full_forecast_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController cityController = TextEditingController();
  ApiClientCall apiClient = ApiClientCall();
  WeatherModel? weatherData;
  String? searchedCity;
  List<WeatherModel> favoriteCitiesData = [];

  Map<String, List<ForecastModel>> forecastPerDay = {};

  @override
  void initState() {
    fetchWeatherData(AppConstants.location); //fetch weather data
    super.initState();
  }

  void fetchWeatherData(String location) async {
    try {
      var newWeatherData = await apiClient.getDataForWeather(location);

      if (newWeatherData != null) {
        print('Fetched temperature: ${newWeatherData.temperature}');
        setState(() {
          weatherData = newWeatherData;
        });
        updateWeatherData(weatherData!);
      } else {
        print('Weather data is null');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  void updateWeatherData(WeatherModel weatherData) {
    if (weatherData != null) {
      setState(() {
        this.weatherData = weatherData;
      });

      // Update weather
      AppConstants.currentWeatherstatus = weatherData.description ?? '';
      AppConstants.weatherIcon =
      '${AppConstants.currentWeatherstatus.replaceAll('', '').toLowerCase()}.png';
      AppConstants.temperature = weatherData.temperature?.toDouble() ?? 0.0; // Update temperature here
      AppConstants.windSpeed = weatherData.windSpeed?.toDouble() ?? 0.0;
      AppConstants.humidity = weatherData.humidity?.toDouble() ?? 0.0;
      AppConstants.temp_min = weatherData.temp_min?.toDouble() ?? 0.0;
      AppConstants.temp_max = weatherData.temp_max?.toDouble() ?? 0.0;
      AppConstants.cloud = weatherData.cloud?.toDouble() ?? 0.0;

      // Forecast data
      forecastPerDay.clear(); // Clear the map to prevent duplicates

      if (weatherData.forecastList != null) {
        for (var entry in weatherData.forecastList!) {
          var dtTxt = entry.date.toString().substring(0, 10);
          if (!forecastPerDay.containsKey(dtTxt)) {
            forecastPerDay[dtTxt] = [];
          }
          forecastPerDay[dtTxt]?.add(entry);
        }
      }
    }
  }

  void addToFavorites() {
    if (weatherData != null) {
      String city = AppConstants.location ?? weatherData?.city ?? '';
     // double? temperature = weatherData!.temperature;

      var newFavoriteCityData = WeatherModel(
        city: city,
        temperature: AppConstants.temperature?.toDouble(),
        windSpeed: AppConstants.windSpeed?.toDouble(),
        humidity: AppConstants.humidity?.toInt(),
        date: weatherData?.date,
        description: AppConstants.currentWeatherstatus,
        cloud: AppConstants.cloud?.toDouble(),
        temp_min: AppConstants.temp_min?.toDouble(),
        temp_max: AppConstants.temp_max?.toDouble(),
        forecastList: List.from(weatherData?.forecastList ?? []),
      );

      setState(() {
        // Check if the city already exists in the favoriteCitiesData list
        if (!favoriteCitiesData.any((favCity) => favCity.city == city)) {
          favoriteCitiesData.add(newFavoriteCityData);
        }
      });

      // You can save the favoriteCitiesData to persistent storage here if needed
    }
  }




  void _addFavoriteCity(WeatherModel newFavoriteCityData) {
    setState(() {
      // Check if the city already exists in the favoriteCitiesData list
      if (!favoriteCitiesData.any((favCity) => favCity.city == newFavoriteCityData.city)) {
        favoriteCitiesData.add(newFavoriteCityData);
      }
    });

    // You can save the favoriteCitiesData to persistent storage here if needed
  }



  @override
  Widget build(BuildContext context) {
    final backgroundInfo = WeatherUtils.getBackgroundInfo(
        AppConstants.currentWeatherstatus);
    final backgroundColor = backgroundInfo['backgroundColor'];
    final backgroundImage = backgroundInfo['backgroundImage'];
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  //image: AssetImage(getBackgroundImage(AppConstants.currentWeatherstatus)),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Container(

                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height45,
                          bottom: Dimensions.height15),
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const WeatherAppIconWidget(
                          //   icon: Icons.menu_outlined,
                          //   backgroundColor: Colors.transparent,
                          // ),
                          Row(
                            children: [
                              //const WeatherAppIconWidget(icon: Icons.location_on, backgroundColor: Colors.transparent,),
                              BigText(
                                text: AppConstants.location!,
                                color: AppColors.mainColor,
                                size: 16,),

                              IconButton(
                                onPressed: () {
                                  cityController.clear();
                                  showMaterialModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                            controller:
                                            ModalScrollController.of(context),
                                            child: Container(
                                              height: size.height * .2,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    width: 70,
                                                    child: Divider(
                                                      thickness: 3.5,
                                                      color:
                                                      AppColors.rainColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    onSubmitted: (location) {
                                                      setState(() {
                                                        AppConstants.location =
                                                            location;
                                                      });
                                                      fetchWeatherData(
                                                          location);
                                                    },
                                                    controller: cityController,
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                          Icons.search,
                                                          color: AppColors
                                                              .rainColor,
                                                        ),
                                                        suffixIcon: GestureDetector(
                                                          onTap: () =>
                                                              cityController
                                                                  .clear(),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: AppColors
                                                                .rainColor,
                                                          ),
                                                        ),
                                                        hintText:
                                                        'Search city e.g. Pretoria',
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: AppColors
                                                                .rainColor,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ),

                            ],
                          ),
                          Center(
                            child: Container(
                              width: Dimensions.height45,
                              height: Dimensions.height45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius15),
                                color: AppColors.mainColor,
                              ),
                              child: Icon(Icons.search, color: Colors.white,
                                size: Dimensions.iconSize24,),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 300,
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      // Set the widthFactor to 1.0 to take full width
                      child: Container(
                        child: Column(
                          children: [
                            CurrentWeatherWidget(
                              temperature: BigText(
                                text: '${AppConstants.temperature ?? ''}\u00B0',
                                size: 50,
                                color: Colors.white,
                              ),
                              rainDescription: SmallText(
                                text: AppConstants.currentWeatherstatus ?? '',
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            //Text('Date:${weatherData!.date}'),
                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width30 / 2, right: Dimensions.width30 / 2),
              child: Container(
                padding: EdgeInsets.only(bottom: Dimensions.height10),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MinCurrentMaxWidget(
                      bigText: BigText(
                        text: '${AppConstants.temp_min ?? ''}\u00B0',
                        color: Colors.white,
                        size: 26,
                      ),
                      //iconImage: 'assets/images/icons/clear@2x.png',
                      smallText: SmallText(
                        text: 'Min',
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    MinCurrentMaxWidget(
                      bigText: BigText(
                        text: '${AppConstants.humidity ?? ''}\u00B0',
                        color: Colors.white,
                        size: 26,
                      ),
                      // iconImage: 'assets/images/icons/clear@2x.png',
                      smallText: SmallText(
                        text: 'Humidity',
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    MinCurrentMaxWidget(
                      bigText: BigText(
                        text: '${AppConstants.temp_max ?? ''}\u00B0',
                        color: Colors.white,
                        size: 26,
                      ),
                      //   iconImage: 'assets/images/icons/clear@2x.png',
                      smallText: SmallText(
                        text: 'Max',
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Divider(
                    thickness: 0.5,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: 'Today',
                    size: 17,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (_) =>
                                FullForcastScreen(
                                  dailyForecastWeather: forecastPerDay,)),
                        ),
                    child: SmallText(
                      text: '5 Day Forecast',
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110,
              child: weatherData?.forecastList != null && weatherData!.forecastList!.isNotEmpty
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: weatherData?.forecastList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  // Get the forecast for the current index
                  var forecast = weatherData?.forecastList?[index];

                  // Check if forecast is not null before returning the widget
                  if (forecast != null) {
                    return Row(
                      children: [
                        SizedBox(width: 10,),
                        HourlyForecastWidget(forecast: forecast,),
                      ],
                    );
                  } else {
                    // If forecast is null, return an empty widget or handle it as you see fit
                    return Container();
                  }
                },
              )
                  : Container(), // Show an empty container if forecastList is empty
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  top: Dimensions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: 'Favourite Cities',
                    size: 17,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoriteListScreen(
                            cityList: favoriteCitiesData,
                          ),
                        ),
                      );
                    },
                    child: SmallText(
                      text: 'cities list',
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DialogUtils.showAddFavoriteCityDialog(
                        context,
                            (newCityModel) {
                          setState(() {
                            // Check if the city already exists in the favoriteCitiesData list
                            if (!favoriteCitiesData.any((favCity) => favCity.city == newCityModel.city)) {
                              favoriteCitiesData.add(newCityModel);
                            }
                          });
                        },
                      );
                    },
                    child: SmallText(
                      text: '+',
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
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
                      text: '${weatherData.description ?? ''}\u00B0',
                      color: Colors.white,
                      size: 12,
                    ),
                    smallText: SmallText(
                      text: '${weatherData.temperature ?? ''}\u00B0',
                      color: Colors.white,
                      size: 24,
                    ),
                    onAddToFavorites: addToFavorites,
                  );
                }).toList(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}