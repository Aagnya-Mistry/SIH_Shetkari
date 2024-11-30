import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sih_shetkari/DefaultLangPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Defaultlangpage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF569358),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 160,
                child: Image.asset(
                  'assets/images/logo (tentative).png',
                  fit: BoxFit.fill,
                ),
              ),
              const Text("Shetkari",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Merriweather",
                      letterSpacing: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
