import 'package:flutter/material.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/SignUpPage.dart';
// import 'package:shetkari_sih/SignUpPage.dart';
// import 'package:shetkari_sih/HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color greenColor = const Color(0xFF4CAF50);
  // Green for focused border and button
  final Color lightGreenColor = const Color(0xFF2A9F5D).withOpacity(0.63);
  // Lighter green for initial background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            const Center(
              child: Text(
                "Sign in to your Account",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Merriweather"),
              ),
            ),
            SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: "Mergeone"),
              ),
            ),
            const SizedBox(height: 0),
            DynamicTextField(
              initialFillColor: lightGreenColor,
              focusedFillColor: Colors.white,
              focusedBorderColor: greenColor,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            const SizedBox(height: 0),
            DynamicTextField(
              initialFillColor: lightGreenColor,
              focusedFillColor: Colors.white,
              focusedBorderColor: greenColor,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
                //Add your login functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text("SIGN IN"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text(
                    "SIGN UP",
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
    );
  }
}

class DynamicTextField extends StatefulWidget {
  final Color initialFillColor;
  final Color focusedFillColor;
  final Color focusedBorderColor;
  final bool obscureText;

  const DynamicTextField({
    super.key,
    required this.initialFillColor,
    required this.focusedFillColor,
    required this.focusedBorderColor,
    this.obscureText = false,
  });

  @override
  _DynamicTextFieldState createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  final FocusNode _focusNode = FocusNode();
  late Color _currentFillColor;

  @override
  void initState() {
    super.initState();
    _currentFillColor = widget.initialFillColor;

    _focusNode.addListener(() {
      setState(() {
        _currentFillColor = _focusNode.hasFocus
            ? widget.focusedFillColor
            : widget.initialFillColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: _currentFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2.0),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
