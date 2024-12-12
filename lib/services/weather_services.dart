import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

// Global variables to store weather data
double? globalTemperature;
double? globalHumidity;
double? globalRainfall;

// Function to fetch weather data for a given city
Future<void> fetchWeatherData(String location) async {
  const String apiKey = '682d0337cemshd966d21fce23698p19ef72jsn6d730c813e9f';
  const String apiHost = 'open-weather13.p.rapidapi.com';
  final String apiUrl = 'https://$apiHost/city/$location/EN';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-Rapidapi-Key': apiKey,
        'X-Rapidapi-Host': apiHost,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Extract and assign data to global variables
      globalTemperature = (data['main']?['temp'] ?? 0.0).toDouble();
      globalHumidity = (data['main']?['humidity'] ?? 0.0).toDouble();
      globalRainfall = (data['rain']?['1h'] ?? 0.0)
          .toDouble(); // Adjust if nested differently

      print('Temperature: $globalTemperature');
      print('Humidity: $globalHumidity');
      print('Rainfall: $globalRainfall');
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to fetch weather data: $e');
  }
}
