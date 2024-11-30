import "package:flutter/material.dart";
import 'package:sih_shetkari/HomePage.dart';

class Slide1 extends StatelessWidget {
  const Slide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Click a picture or upload an image of your crop to get detailed insights",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide6()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontFamily: "Mergeone",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide2()),
                      );
                    },
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Mergeone",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide2 extends StatelessWidget {
  const Slide2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        color: Colors.transparent,
                        width: 30,
                        height: 30,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        )))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Disease identification and its cause",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide6()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontFamily: "Mergeone",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(
                          backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide3()),
                      );
                    },
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Mergeone",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide3 extends StatelessWidget {
  const Slide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Preventive measures and suggested medicines",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide6()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontFamily: "Mergeone",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(
                          backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide4()),
                      );
                    },
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Mergeone",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide4 extends StatelessWidget {
  const Slide4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Current weather conditions tailored to your region",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide6()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontFamily: "Mergeone",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(
                          backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide5()),
                      );
                    },
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Mergeone",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide5 extends StatelessWidget {
  const Slide5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Crop Recommendations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          fontFamily: "Mergeone",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(
                          backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      SizedBox(width: 4),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Slide6()),
                      );
                    },
                    child: const Text("Next",
                        style: TextStyle(
                            fontFamily: "Mergeone",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Slide6 extends StatelessWidget {
  const Slide6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Center(
                  child: Text(
                    "Allow us to use your device location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather"),
                  ),
                ),
              ),
              const Text("Latitude:"),
              const Text("Longitutde: ")
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 160),
                    child: Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                        SizedBox(width: 4),
                        CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                        SizedBox(width: 4),
                        CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                        SizedBox(width: 4),
                        CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                        SizedBox(width: 4),
                        CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                        SizedBox(width: 4),
                        CircleAvatar(
                            backgroundColor: Color(0xFF2A9F5D), radius: 5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: const Text("Accept",
                          style: TextStyle(
                              fontFamily: "Mergeone",
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
