// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite/tflite.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:path_provider/path_provider.dart';
// import 'package:sih_shetkari/HomePage.dart';

// class TFLiteModel {
//   static late List<String> classLabels;
//   static late String modelPath;

//   // Load model and class labels
//   static Future<void> loadModel() async {
//     try {
//       // Load model from assets
//       String? res = await Tflite.loadModel(
//           model: 'assets/models/you_are_just_a_chill_ml_model.tflite',
//           labels: 'assets/models/class_mapping.json');
//       print("Model loaded: $res");

//       // Load class labels from class_mapping.json
//       final String jsonString =
//           await rootBundle.loadString('assets/models/class_mapping.json');
//       List<String> labels = List<String>.from(jsonDecode(jsonString));
//       classLabels = labels;
//     } catch (e) {
//       print("Failed to load model: $e");
//     }
//   }

//   // Perform inference on the input image
//   static Future<String> predictDisease(File image) async {
//     try {
//       // Preprocess the image (resize and normalize)
//       final img.Image? imageBytes = img.decodeImage(image.readAsBytesSync());
//       final img.Image resizedImage =
//           img.copyResize(imageBytes!, width: 224, height: 224);

//       // Convert image to tensor
//       final List<List<List<int>>> input = [
//         List.generate(
//           224,
//           (i) => List.generate(224, (j) => resizedImage.getPixel(j, i)),
//         )
//       ];

//       // Run inference on the model
//       var output = await Tflite.runModelOnImage(
//         path: image.path,
//         numResults: 1,
//         threshold: 0.1,
//       );

//       // Extract predicted label
//       String prediction = classLabels[output?[0]['label']];
//       return prediction;
//     } catch (e) {
//       print("Prediction failed: $e");
//       return 'Error';
//     }
//   }

//   // Clean up resources after use
//   static Future<void> closeModel() async {
//     await Tflite.close();
//   }
// }

import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TFLiteModel {
  static late List<String> classLabels;
  static late String modelPath;

  // Load model and class labels
  static Future<void> loadModel() async {
    try {
      // Load model from assets
      String? res = await Tflite.loadModel(
        model: 'assets/models/you_are_just_a_chill_ml_model.tflite',
        labels: 'assets/models/class_mapping.json',
      );
      print("Model loaded: $res");

      // Load class labels from class_mapping.json
      final String jsonString =
          await rootBundle.loadString('assets/models/class_mapping.json');
      List<String> labels = List<String>.from(jsonDecode(jsonString));
      classLabels = labels;
    } catch (e) {
      print("Failed to load model: $e");
    }
  }

  // Download image from URL and save to a temporary file
  static Future<File> downloadImage(String imageUrl) async {
    try {
      // Send an HTTP request to get the image data
      var response = await http.get(Uri.parse(imageUrl));
      var bytes = response.bodyBytes;

      // Get the temporary directory
      final directory = await getTemporaryDirectory();

      // Create a file in the temporary directory
      File tempFile = File('${directory.path}/image.jpg');

      // Write the image bytes to the file
      await tempFile.writeAsBytes(bytes);

      return tempFile;
    } catch (e) {
      print("Error downloading image: $e");
      rethrow;
    }
  }

  // Perform inference on the input image (given the image URL)
  static Future<String> predictDiseaseFromUrl(String imageUrl) async {
    try {
      // Download the image from the URL and get the local file path
      File imageFile = await downloadImage(imageUrl);

      // Preprocess the image (resize and normalize)
      final img.Image? imageBytes =
          img.decodeImage(imageFile.readAsBytesSync());
      final img.Image resizedImage =
          img.copyResize(imageBytes!, width: 224, height: 224);

      // Convert image to tensor (necessary preprocessing for TFLite model)
      final List<List<List<int>>> input = [
        List.generate(
          224,
          (i) => List.generate(224, (j) => resizedImage.getPixel(j, i)),
        )
      ];

      // Run inference on the model (pass the local file path)
      var output = await Tflite.runModelOnImage(
        path: imageFile.path, // Use the local file path
        numResults: 1,
        threshold: 0.1,
      );

      // Extract predicted label from the output
      if (output != null && output.isNotEmpty) {
        String prediction = classLabels[output[0]['label']];
        return prediction;
      } else {
        return 'Prediction Error';
      }
    } catch (e) {
      print("Prediction failed: $e");
      return 'Error';
    }
  }

  // Clean up resources after use
  static Future<void> closeModel() async {
    await Tflite.close();
  }
}
