import 'package:flutter/material.dart';
import 'package:sih_shetkari/Slides.dart';
//import 'package:shetkari_sih/Slides.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Color greenColor = const Color(0xFF4CAF50);
  // Green for focused border and button
  final Color lightGreenColor = const Color(0xFF2A9F5D).withOpacity(0.63);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      const Text(
                        "Create your account",
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
                const Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Mergeone"),
                ),
                const SizedBox(height: 0),
                DynamicTextField(
                  initialFillColor: lightGreenColor,
                  focusedFillColor: Colors.white,
                  focusedBorderColor: greenColor,
                ),
                const SizedBox(height: 20),

                //Contact No. Text Box
                const Text(
                  "Contact No.",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Mergeone"),
                ),
                const SizedBox(height: 0),
                DynamicTextField(
                  initialFillColor: lightGreenColor,
                  focusedFillColor: Colors.white,
                  focusedBorderColor: greenColor,
                ),
                const SizedBox(height: 20),

                //Password Text Box
                const Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Mergeone"),
                ),
                const SizedBox(height: 0),
                DynamicTextField(
                  obscureText: true,
                  initialFillColor: lightGreenColor,
                  focusedFillColor: Colors.white,
                  focusedBorderColor: greenColor,
                ),
                const SizedBox(height: 20),

                //Confirm Password
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Mergeone"),
                ),
                const SizedBox(height: 0),
                DynamicTextField(
                  obscureText: true,
                  initialFillColor: lightGreenColor,
                  focusedFillColor: Colors.white,
                  focusedBorderColor: greenColor,
                ),
                const SizedBox(height: 30),

                //Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Slide1()));
                    // Add your sign-up functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("SIGN UP"),
                ),
                const SizedBox(height: 20),

                //If already has an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontFamily: "Mergeone", fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "SIGN IN",
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
