import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/constants/colors.dart';
import '../../../models/weather_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/background_utils.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/current_weather_widget.dart';
import '../../../widgets/min_current_max_widget.dart';
import '../../../widgets/small_text.dart';
import '../../../widgets/weather_app_icon_widget.dart';

class FullForcastScreen extends StatefulWidget {
  final Map<String, List<ForecastModel>> dailyForecastWeather;

  const FullForcastScreen({Key? key, required this.dailyForecastWeather})
      : super(key: key);

  @override
  State<FullForcastScreen> createState() => _FullForcastScreenState();
}

class _FullForcastScreenState extends State<FullForcastScreen> {
  Map<String, List<ForecastModel>> get weatherData => widget.dailyForecastWeather;

  Map<String, dynamic> get backgroundInfo =>
      WeatherUtils.getBackgroundInfo(AppConstants.currentWeatherstatus);

  Color get backgroundColor => backgroundInfo['backgroundColor'];
  String get backgroundImage => backgroundInfo['backgroundImage'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Forecasts'),
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
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body:Column(
        children: [
          SizedBox(
            height: 360,
            child: FractionallySizedBox(
              widthFactor: 1.0, // Set the widthFactor to 1.0 to take full width
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 80),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),

                    //image: AssetImage(getBackgroundImage(AppConstants.currentWeatherstatus)),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    CurrentWeatherWidget(
                      temperature: BigText(
                        text: '${AppConstants.temperature ?? ''}°',
                        size: 50,
                        color: Colors.white,
                      ),
                      rainDescription: SmallText(
                        text: AppConstants.currentWeatherstatus ?? '',
                        color: Colors.white,
                        size: 18,
                      ),
                    ),

                  ],
                ),
              ),

            ),

          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.width30 / 2, right: Dimensions.width30 / 2,),
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
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Divider(
                  thickness: 0.5,
                  color:Colors.white
              ),
            ),
          ),
          Expanded(
              child:ListView.builder(
                itemCount: weatherData.length,
                itemBuilder: (context, index) {
                  var date = weatherData.keys.toList()[index];
                  var forecastList = weatherData[date];

                  var maxTemp = forecastList?.last.temperature!.toInt();
                  var getParsedDate = forecastList?.first.date;
                  var weatherName = forecastList?.first.description;
                  var weatherIcon = "${weatherName?.replaceAll(' ', '').toLowerCase()}.png";
                  var minTemperature = forecastList?.first.temperature!.toInt();
                  var maxTemperature = forecastList?.last.temperature!.toInt();

                  var forecastData = {
                    'forecastDate': getParsedDate,
                    'weatherName': weatherName,
                    'weatherIcon': weatherIcon,
                    'minTemperature': minTemperature,
                    'maxTemperature': maxTemperature,
                  };

                  return Card(
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Use a fixed size for the container holding the icon
                              SizedBox(
                                width: 80,
                                child: SmallText(text: DateFormat('EEEE').format(DateTime.parse(date)), size: 18,),
                              ),
                              Center(
                                child: WeatherAppIconWidget(
                                  icon: Image.asset('assets/images/icons/${forecastData['weatherIcon']}', width: 30),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Row(
                                children: [
                                  BigText(text: '${forecastData['maxTemperature']}°', size: 30,),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 5),
                                  Text(
                                    forecastData['weatherName'].toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );




                },
              ),),
        ],
      ),
    );
  }
}
