import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

bool isDefected = false;
String diseaseName = "";
String severity = "";
String cure = "";
String preventiveMeasures = "";

Future<String?> uploadToCloudinary(File file) async {
  // Ensure the file is not null
  if (file == null) {
    print("No file selected");
    return null;
  }

  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  // Make sure to set up the Cloudinary URL
  var uri = Uri.parse("https://api.cloudinary.com/v1_1/dmqiossox/image/upload");

  var request = http.MultipartRequest("POST", uri);

  // Read the file contents to bytes
  var fileBytes = await file.readAsBytes();

  var multipartFile = http.MultipartFile.fromBytes('file', fileBytes,
      filename: file.path.split("/").last);

  request.files.add(multipartFile);
  request.fields['upload_preset'] =
      "CropDiseases"; // Make sure the preset is correct
  request.fields['resource_type'] = "image";

  // Send the request
  var response = await request.send();
  var responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(responseBody);
    print("Upload successful! URL: ${jsonResponse['secure_url']}");

    String imageUrl = jsonResponse['secure_url'];
    return imageUrl;
  } else {
    print("Upload failed with status: ${response.statusCode}");
    return null;
  }
}

Future<void> saveDetailsToFirestore({
  required String imageUrl,
  required bool isDefected,
  required String diseaseName,
  required String severity,
  required String cure,
  required String preventiveMeasures,
}) async {
  try {
    // Get current timestamp
    String timestamp = DateFormat('ddMMyyyyHHmmss').format(DateTime.now());

    // Create a new Firestore collection reference
    CollectionReference imagesCollection =
        FirebaseFirestore.instance.collection('UploadedImages');

    // Save data to Firestore
    await imagesCollection.add({
      'image_url': imageUrl,
      'timestamp': timestamp,
      'is_defected': isDefected,
      'disease_name': diseaseName,
      'severity': severity,
      'cure': cure,
      'preventive_measures': preventiveMeasures,
    });

    print("Data saved to Firestore successfully!");
  } catch (e) {
    print("Failed to save data to Firestore: $e");
  }
}
