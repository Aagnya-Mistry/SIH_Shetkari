import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sih_shetkari/DefaultLangPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_shetkari/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();

    whereToNavigate();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }

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
              Text(localizations.shetkari,
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

  Future<void> whereToNavigate() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Defaultlangpage()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Defaultlangpage()));
      }
    });
  }
}
