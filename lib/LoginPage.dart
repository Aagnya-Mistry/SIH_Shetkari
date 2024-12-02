import 'package:flutter/material.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Color greenColor = const Color(0xFF4CAF50);
  // Green for focused border and button
  final Color lightGreenColor = const Color(0xFF2A9F5D).withOpacity(0.63);
  // Lighter green for initial background

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  void signInWithPhoneAndPassword(BuildContext context) async {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      // Fetch user data from Firestore
      final userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(phone).get();

      if (!userSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No user found with this phone number")),
        );
        return;
      }

      final userData = userSnapshot.data();
      final hashedInputPassword = hashPassword(password);

      if (userData != null && userData['password'] == hashedInputPassword) {
        // User is authenticated
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in successfully!")),
        );

        // Perform navigation or app-specific actions here
        // For example, navigate to a placeholder home screen:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Replace with your desired page
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Incorrect password")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/logo (tentative).png',
                      height: 100), // Replace with your asset
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    localizations.login_heading,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
                SizedBox(height: 30),

                //Username Textfield
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localizations.username,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Mergeone"),
                  ),
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
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 0),

                //Password Textfield
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localizations.password,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
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
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 0),

                //Sign In Button
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    signInWithPhoneAndPassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(localizations.signin),
                ),

                //Sign Up Option
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localizations.signup_txt),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: Text(
                        localizations.signup,
                        style: TextStyle(
                          color: greenColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
