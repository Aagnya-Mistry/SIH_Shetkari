import 'package:flutter/material.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/PreventionPage.dart';
import 'package:sih_shetkari/FarmDetailsPage.dart';
import 'package:sih_shetkari/VoiceAssitant.dart';

class Diseaseinfopage extends StatefulWidget {
  final String imageURL;
  final String prediction;

  const Diseaseinfopage({required this.imageURL, required this.prediction});

  @override
  State<Diseaseinfopage> createState() => _DiseaseinfopageState();
}

class _DiseaseinfopageState extends State<Diseaseinfopage> {
  int currentIndex = 0;

  late List<Widget> pages;

  final List<IconData> icons = [
    Icons.home,
    Icons.agriculture,
    Icons.medical_information,
    Icons.calendar_month,
    Icons.recommend,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the pages list with required parameters
    pages = [
      const HomePage(),
      Diseaseinfopage(imageURL: widget.imageURL, prediction: widget.prediction),
      const Preventionpage(),
      VoiceAssistantPage(),
      FarmDetails(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Text(
            "Disease Prediction",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Merriweather"),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Add bookmark functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.prediction.isNotEmpty
                        ? widget.prediction
                        : "No disease detected",
                    style: const TextStyle(
                        fontFamily: "Merriweather",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 12,
                              offset: Offset(0, 2))
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        widget.imageURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const Text(
                    "About the Disease",
                    style: TextStyle(
                      fontFamily: "Merriweather",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet urna vel sapien cursus pharetra a sed justo. Curabitur tincidunt augue at efficitur varius.",
                    style: TextStyle(fontFamily: "Mergeone", fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What Caused it?",
                    style: TextStyle(
                        fontFamily: "Merriweather",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet urna vel sapien cursus pharetra a sed justo. Curabitur tincidunt augue at efficitur varius.",
                    style: TextStyle(fontFamily: "Mergeone", fontSize: 14),
                  ),
                  const SizedBox(height: 85),
                ],
              ),
            ),
          ),
          // Bottom Navigation Buttons
          Align(alignment: Alignment.bottomCenter, child: _navBar())
        ],
      ),
    );
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A9F5D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1D4031), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: icons.map((e) {
          int index = icons.indexOf(e);
          bool isSelected = currentIndex == index;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pages[index]),
                  );
                });
              },
              child: Icon(
                e,
                color: isSelected ? Colors.black54 : Colors.white,
                size: 35,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
