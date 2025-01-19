import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String nitrogen = '';
String phosphorus = '';
String potassium = '';
String temperature = '';
String humidity = '';
String soilPh = '';
String rainfall = '';

class FarmDetails extends StatefulWidget {
  @override
  State<FarmDetails> createState() => _FarmDetailsState();
}

class _FarmDetailsState extends State<FarmDetails> {
  final TextEditingController _nitrogenController = TextEditingController();
  final TextEditingController _phosphorusController = TextEditingController();
  final TextEditingController _potassiumController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _rainfallController = TextEditingController();

  String _predictedCrop = '';

  // Crop mapping (predicted number -> crop name)
  final Map<int, String> cropMapping = {
    0: 'Apple',
    1: 'Banana',
    2: 'Blackgram',
    3: 'Chickpea',
    4: 'Coconut',
    5: 'Coffee',
    6: 'Cotton',
    7: 'Grapes',
    8: 'Jute',
    9: 'Kidney Beans',
    10: 'Lentil',
    11: 'Maize',
    12: 'Mango',
    13: 'Mothbeans',
    14: 'Mungbean',
    15: 'Muskmelon',
    16: 'Orange',
    17: 'Papaya',
    18: 'Pigeonpeas',
    19: 'Pomegranate',
    20: 'Rice',
    21: 'Watermelon'
  };

  Future<void> _getRecommendation() async {
    final String apiUrl =
        'http://192.168.187.59:5000/recommend-crop'; // Replace with your Flask server IP

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nitrogen': _nitrogenController.text,
        'phosphorus': _phosphorusController.text,
        'potassium': _potassiumController.text,
        'temperature': _temperatureController.text,
        'humidity': _humidityController.text,
        'ph': _phController.text,
        'rainfall': _rainfallController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Convert the numeric prediction to crop name
        int predictedCropNum = data['crop'];
        _predictedCrop = cropMapping[predictedCropNum] ??
            'Unknown Crop'; // Fallback to 'Unknown Crop' if the number is not mapped
      });
    } else {
      setState(() {
        _predictedCrop = 'Error: Unable to fetch recommendation';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          localizations.page3,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Merriweather"),
        ),
        //elevation: 0,
      ),
      body: SingleChildScrollView(
        // Enables scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image and title
              Center(
                child: Image.asset(
                  'assets/images/fertilizer.png',
                  width: 90,
                  height: 90,
                ),
              ),
              Text(
                localizations.enter_farm_details,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Mergeone"),
              ),

              //N content
              SizedBox(height: 10),
              TextField(
                controller: _nitrogenController,
                decoration: InputDecoration(
                  labelText: localizations.n_content,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => nitrogen = value,
              ),

              //P content
              SizedBox(height: 10),
              TextField(
                controller: _phosphorusController,
                decoration: InputDecoration(
                  labelText: localizations.p_content,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => phosphorus = value,
              ),

              //K content
              SizedBox(height: 10),
              TextField(
                controller: _potassiumController,
                decoration: InputDecoration(
                  labelText: localizations.k_content,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => potassium = value,
              ),

              //Temperature in (degree centigrade)
              SizedBox(height: 10),
              TextField(
                controller: _temperatureController,
                decoration: InputDecoration(
                  labelText: localizations.temp,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => temperature = value,
              ),

              //Humidity(%)
              SizedBox(height: 10),
              TextField(
                controller: _humidityController,
                decoration: InputDecoration(
                  labelText: localizations.humidity,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => humidity = value,
              ),

              //Soil ph
              SizedBox(height: 10),
              TextField(
                controller: _phController,
                decoration: InputDecoration(
                  labelText: localizations.soil_ph,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => soilPh = value,
              ),

              //Rainfall
              SizedBox(height: 10),
              TextField(
                controller: _rainfallController,
                decoration: InputDecoration(
                  labelText: localizations.rain,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => rainfall = value,
              ),
              SizedBox(
                height: 20,
              ),
              //Submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _getRecommendation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    localizations.get_recommend,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                localizations.recommended + ": $_predictedCrop",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Merriweather"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
