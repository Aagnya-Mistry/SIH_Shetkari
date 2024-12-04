import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> uploadToCloudinary(ImageSource source) async {
  // Create an instance of ImagePicker
  final picker = ImagePicker();

  // Pick image from camera or gallery
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile == null) {
    print("No image selected");
    return null;
  }

  File file = File(pickedFile.path);

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
  print(response);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(responseBody);
    print("Upload successful! URL: ${jsonResponse['secure_url']}");
    return jsonResponse['secure_url'];
  } else {
    print("Upload failed with status: ${response.statusCode}");
    return null;
  }
}
