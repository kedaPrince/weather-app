import 'package:flutter/material.dart';
import 'package:weather_app/src/constants/colors.dart';
import 'package:weather_app/src/utils/app_constants.dart';

class WeatherAppIconWidget extends StatelessWidget {
  //what we need for the icons-->icon itself, color of icon , bag color for the container and size of the container and size of icon
  final Image icon;
  final double iconSize;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const WeatherAppIconWidget({super.key,
    required this.icon,
    this.iconSize = 16,
    this.size = 40,
    this.backgroundColor = const Color(0xFFa9a29f),
    this.iconColor = const  Color(0xFFf7f6f4)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      child: icon,
    );
  }
}
