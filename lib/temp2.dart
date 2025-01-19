// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crop Disease Predictor',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DiseasePredictionPage(),
//     );
//   }
// }

// class DiseasePredictionPage extends StatefulWidget {
//   @override
//   _DiseasePredictionPageState createState() => _DiseasePredictionPageState();
// }

// class _DiseasePredictionPageState extends State<DiseasePredictionPage> {
//   String _disease = '';
//   XFile? _image;
//   final ImagePicker _picker = ImagePicker();

//   // Method to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = pickedImage;
//     });
//   }

//   // Method to capture an image using the camera
//   Future<void> _captureImage() async {
//     final XFile? capturedImage =
//         await _picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = capturedImage;
//     });
//   }

//   // Method to send image to API and get the disease prediction
//   Future<String> sendImageToApi(File image) async {
//     // Replace <your-local-ip> and <port> with actual values
//     Uri uri = Uri.parse('http://192.168.187.59:5000/predict');

//     var request = http.MultipartRequest('POST', uri)
//       ..files.add(await http.MultipartFile.fromPath('file', image.path));

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseBody = await response.stream.bytesToString();
//       return responseBody; // Assuming the response is the disease prediction
//     } else {
//       return 'Error: ${response.statusCode}';
//     }
//   }

//   // Method to predict the disease after the image is selected
//   void _predictDisease() async {
//     if (_image != null) {
//       String prediction = await sendImageToApi(File(_image!.path));
//       setState(() {
//         _disease = prediction;
//       });
//     } else {
//       setState(() {
//         _disease = 'No image selected';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Disease Prediction'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             // Image display and picker
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(File(_image!.path), height: 250),
//             SizedBox(height: 20),
//             // Buttons to pick or capture an image
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image from Gallery'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _captureImage,
//               child: Text('Capture Image with Camera'),
//             ),
//             SizedBox(height: 20),
//             // Predict disease button
//             ElevatedButton(
//               onPressed: _predictDisease,
//               child: Text('Predict Disease'),
//             ),
//             SizedBox(height: 20),
//             // Display the predicted disease
//             _disease.isEmpty
//                 ? Container()
//                 : Text(
//                     'Predicted Disease: $_disease',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
