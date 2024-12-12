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
  String _recommendedFertilizer = '';
  bool showRecommendations = false;

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

  Future<void> _getCropRecommendation() async {
    final String cropApiUrl =
        'http://192.168.187.59:5000/recommend-crop'; // Replace with your Flask server IP

    final response = await http.post(
      Uri.parse(cropApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nitrogen': nitrogen,
        'phosphorus': phosphorus,
        'potassium': potassium,
        'temperature': temperature,
        'humidity': humidity,
        'ph': soilPh,
        'rainfall': rainfall,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        int predictedCropNum = data['crop'];
        _predictedCrop = cropMapping[predictedCropNum] ?? 'Unknown Crop';
      });
    } else {
      setState(() {
        _predictedCrop = 'Error: Unable to fetch crop recommendation';
      });
    }
  }

  Future<void> _getFertilizerRecommendation() async {
    final String fertilizerApiUrl =
        'http://192.168.187.59:5000/recommend-fertilizer'; // Replace with your Flask server IP

    final response = await http.post(
      Uri.parse(fertilizerApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nitrogen': nitrogen,
        'phosphorus': phosphorus,
        'potassium': potassium,
        'temperature': temperature,
        'humidity': humidity,
        'ph': soilPh,
        'rainfall': rainfall,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _recommendedFertilizer = data['fertilizer'] ?? 'Unknown Fertilizer';
      });
    } else {
      setState(() {
        _recommendedFertilizer =
            'Error: Unable to fetch fertilizer recommendation';
      });
    }
  }

  Future<void> _getRecommendations() async {
    setState(() {
      _predictedCrop = 'Sample Crop';
      _recommendedFertilizer = 'Sample Fertilizer';
      showRecommendations = true; // Force UI update
    });
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
          localizations.page_3,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Merriweather"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: 10),
              // Input fields
              ..._buildInputFields(),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _getRecommendations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    localizations.get_recommend,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (showRecommendations) ...[
                Text(
                  localizations.recommended + ": $_predictedCrop",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Recommended Fertilizer: $_recommendedFertilizer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInputFields() {
    return [
      _buildTextField(AppLocalizations.of(context)!.n_content,
          _nitrogenController, (value) => nitrogen = value),
      _buildTextField(AppLocalizations.of(context)!.p_content,
          _phosphorusController, (value) => phosphorus = value),
      _buildTextField(AppLocalizations.of(context)!.k_content,
          _potassiumController, (value) => potassium = value),
      _buildTextField(AppLocalizations.of(context)!.temp,
          _temperatureController, (value) => temperature = value),
      _buildTextField(AppLocalizations.of(context)!.humidity,
          _humidityController, (value) => humidity = value),
      _buildTextField(AppLocalizations.of(context)!.soil_ph, _phController,
          (value) => soilPh = value),
      _buildTextField(AppLocalizations.of(context)!.rain, _rainfallController,
          (value) => rainfall = value),
    ];
  }

  Widget _buildTextField(String label, TextEditingController controller,
      Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}
