import 'package:flutter/material.dart';
import 'package:weather_app/src/widgets/big_text.dart';
import 'package:weather_app/src/widgets/small_text.dart';

import '../utils/dimensions.dart';

class CurrentWeatherWidget extends StatelessWidget {
  //final IconData icon;
  final BigText temperature;
  final SmallText rainDescription;
  const CurrentWeatherWidget({super.key, required this.temperature, required this.rainDescription});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 5,),
          temperature,
          SizedBox(height: 20), // Add some spacing between temperature and rain description
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, // Limit the width of the rain description
            ),
            child: rainDescription,
          ),
        ],
      ),
    );
  }
}
