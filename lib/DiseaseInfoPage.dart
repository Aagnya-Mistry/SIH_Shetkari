import 'package:flutter/material.dart';
import 'package:sih_shetkari/GovtSchemas.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/PreventionPage.dart';
import 'package:sih_shetkari/FarmDetailsPage.dart';
import 'package:sih_shetkari/VoiceAssitant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Diseaseinfopage extends StatefulWidget {
  final String imageURL;

  const Diseaseinfopage({required this.imageURL});

  @override
  State<Diseaseinfopage> createState() => _DiseaseinfopageState();
}

class _DiseaseinfopageState extends State<Diseaseinfopage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            localizations.page2,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Disease Name",
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
    );
  }
}
