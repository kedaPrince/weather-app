import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class DialogUtils {
  static void showAddFavoriteCityDialog(
      BuildContext context,
      void Function(WeatherModel) onCityAdded,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        String newCity = ''; // To store the new city name

        return AlertDialog(
          title: Text('Add Favorite City'),
          content: TextField(
            onChanged: (value) {
              newCity = value; // Update the new city name as the user types
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without adding the city
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newCity.isNotEmpty) {
                  // Create a new WeatherModel object with the new city name
                  WeatherModel newCityModel = WeatherModel(city: newCity);
                  // Call the onCityAdded callback with the new WeatherModel object
                  onCityAdded(newCityModel);
                }
                Navigator.pop(context); // Close the dialog after adding the city
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

