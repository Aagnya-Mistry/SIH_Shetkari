import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sih_shetkari/HomePage.dart';

class DiseaseDetection extends StatefulWidget {
  const DiseaseDetection({super.key});

  @override
  State<DiseaseDetection> createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _diseaseName;
  bool _isLoading = false;

  final String baseUrl = 'https://crop-disease-detector-gg0o.onrender.com/';

  /// Function to pick an image from the camera
  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  /// Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  /// Function to upload the image to the server
  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // API Endpoint
      final url = Uri.parse('$baseUrl/predict');

      // Create a multipart request
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      ));

      // Send the request and get the response
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData.body);

        setState(() {
          _diseaseName = jsonResponse['disease-name'];
        });
      } else {
        throw Exception('Failed to load. Status code: ${response.statusCode}');
      }
    } catch (e) {
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
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return const Text('Localization not available'); // Fallback text
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          ),
        ),
        title: Center(
          child: Text(
            localizations.page2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Merriweather",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Identify crop diseases with ease! Upload a photo of your plant, and our AI-powered tool will detect the disease and provide preventive measures to protect your crops and ensure a healthy harvest.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Mergeone",
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _pickImageFromCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text(
                "Click an Image from Camera",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Mergeone",
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A9F5D),
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text(
                "Upload an Image from Gallery",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Mergeone",
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A9F5D),
                iconColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_diseaseName != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Disease Detected: $_diseaseName',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 85, 56),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                      File(_image!.path),
                      width: 350,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
