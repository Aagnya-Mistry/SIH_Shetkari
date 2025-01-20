import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sih_shetkari/HomePage.dart';

class DiseaseInfoPage extends StatefulWidget {
  const DiseaseInfoPage({super.key});

  @override
  _DiseaseInfoPageState createState() => _DiseaseInfoPageState();
}

class _DiseaseInfoPageState extends State<DiseaseInfoPage> {
  File? _selectedImage;
  bool _isLoading = false;
  String? _healthStatus;
  double? _predictedHpi;
  String? _spectralImagePath;

  final String baseUrl =
      'https://plant-health-index-hpi-04x5.onrender.com'; // Base URL for the server

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final selectedSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
    if (selectedSource != null) {
      final XFile? image = await picker.pickImage(source: selectedSource);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _spectralImagePath = null;
          _healthStatus = null;
          _predictedHpi = null;
        });
        await _uploadImage();
      }
    }
  }

  /// Function to upload the image and fetch analysis from the server
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print("Uploading image...");

      var url = Uri.parse('$baseUrl/health_status');
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _selectedImage!.path,
      ));

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      print('Response status: ${response.statusCode}');
      print('Response body: ${responseData.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseData.body);

        setState(() {
          _predictedHpi = jsonResponse['predicted_hpi']?.toDouble();
          _healthStatus = jsonResponse['health_status'];

          if (jsonResponse['spectral_image'] != null) {
            _spectralImagePath =
                Uri.parse('$baseUrl${jsonResponse['spectral_image']}')
                    .toString();
            print('Spectral image path: $_spectralImagePath');
          } else {
            print('Spectral image key is missing or null');
            _spectralImagePath = null;
          }
        });
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())),
        ),
        title: const Center(
          child: Text(
            "NDIV Test Analyzer",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Merriweather"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NDVI Test (Normalized Difference Vegetation Index):",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Merriweather",
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 2, 85, 56))),
                  Text(
                      "The NDVI test is a method used to assess plant health by analyzing the difference between visible (red) and near-infrared (NIR) light reflected by vegetation. Healthy plants reflect more NIR and less red light, resulting in higher NDVI values (close to 1), while stressed or diseased plants reflect less NIR and have lower NDVI values (close to -1). It helps monitor crop health, detect diseases, and manage agricultural practices effectively.",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Mergeone",
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text("HPI (Health Plant Index):",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Merriweather",
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 2, 85, 56))),
                  Text(
                      "The Health Plant Index (HPI) quantifies the overall health status of plants based on image data, typically measuring attributes like leaf color, texture, or structural integrity. In diseased plants, the HPI tends to be lower due to discoloration, spots, or damage caused by pests or diseases. HPI helps categorize plant health into levels like \"Poor,\" \"Moderate,\" \"Good,\" or \"Excellent,\" aiding in early detection and intervention for crop management.",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Mergeone",
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.file(
                        _selectedImage!,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A9F5D),
                      iconColor: Colors.white,
                    ),
                    child: const Text(
                      'Select Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Mergeone",
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _uploadImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A9F5D),
                      iconColor: Colors.white,
                    ),
                    child: const Text(
                      'Upload and Analyze',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Mergeone",
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isLoading) const CircularProgressIndicator(),
              if (_healthStatus != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Health Status: $_healthStatus',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Mergeone",
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Predicted HPI: ${_predictedHpi?.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Mergeone",
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
