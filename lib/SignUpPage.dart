import 'package:flutter/material.dart';
import 'package:sih_shetkari/LoginPage.dart';
import 'package:sih_shetkari/Slides.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Color greenColor = const Color(0xFF4CAF50);
  // Green for focused border and button
  final Color lightGreenColor = const Color(0xFF2A9F5D).withOpacity(0.63);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hash the password before storing
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Function to sign up the user
  void signUpWithPhone(BuildContext context) async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Input Validation
    if (name.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters long")),
      );
      return;
    }

    try {
      // Store user data in Firestore
      String hashedPassword = hashPassword(password);

      await FirebaseFirestore.instance.collection('users').doc(phone).set({
        'name': name,
        'phone': phone,
        'password': hashedPassword,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Slide1()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-up failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //heading and image
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "assets/images/farmer.png",
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            localizations.signup_heading,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "Merriweather"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    //Name Text Box
                    Text(
                      localizations.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Mergeone"),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Contact No. Text Box
                    Text(
                      localizations.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Mergeone"),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "+1234567890",
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Password Text Box
                    Text(
                      localizations.password,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Mergeone"),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Confirm Password
                    Text(
                      localizations.confirm,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Mergeone"),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm your password",
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    //Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        signUpWithPhone(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(localizations.signup),
                    ),
                    const SizedBox(height: 20),

                    //If already has an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizations.signin_txt,
                          style:
                              TextStyle(fontFamily: "Mergeone", fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            localizations.signin,
                            style: TextStyle(
                                color: greenColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Mergeone"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
