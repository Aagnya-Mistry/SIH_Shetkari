import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sih_shetkari/DiseaseDetection.dart';
import 'dart:io';
import 'package:sih_shetkari/DiseaseInfoPage.dart';
import 'package:sih_shetkari/DiseasePrediction.dart';
import 'package:sih_shetkari/GovtSchemas.dart';
import 'package:sih_shetkari/HelpPage.dart';
import 'package:sih_shetkari/Language_provider.dart';
import 'package:sih_shetkari/PreventionPage.dart';
import 'package:sih_shetkari/ProfilePage.dart';
import 'package:sih_shetkari/FarmDetailsPage.dart';
import 'package:sih_shetkari/VoiceAssitant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sih_shetkari/services/cloudinary_services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  //FilePickerResult? _filePickerResult;
  XFile? imagefile;
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const DiseaseInfoPage(),
    DiseasePrediction(),
    const Preventionpage(),
    VoiceAssistantPage(),
    FarmDetails(),
    const GovtschemasPage()
  ];
  final List<IconData> icons = [
    Icons.home,
    Icons.agriculture,
    Icons.online_prediction,
    Icons.medical_information,
    Icons.mic,
    Icons.recommend,
    Icons.article_outlined
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            // Image and welcome to shetkari text with lang dropdown, help, profile icon
            Stack(children: [
              Container(
                height: 350,
                width: 500,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(50)),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      // Adjust opacity for a softer shadow
                      blurRadius: 20,
                      // Set the blur radius
                      offset: const Offset(0,
                          10), // Set the shadow's offset (horizontal, vertical)
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/homepage.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: 500,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFF569358).withOpacity(0.45),
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          });
                        },
                        child: const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        localizations.welcome_head,
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Merriweather',
                            color: Colors.white),
                      ),
                      Text(
                        localizations.shetkari,
                        style: TextStyle(
                            fontSize: 65,
                            fontFamily: 'Merriweather',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: Color(0xFF1D4031),
                              //   width: 3
                              // )
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.language,
                                  color: Color(0xFF1D4031),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownMenu(
                                  inputDecorationTheme: InputDecorationTheme(
                                      fillColor: Colors.transparent),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Mergeone",
                                    color: Color(0xFF1D4031),
                                  ),
                                  initialSelection: Text(context
                                      .watch<LanguageProvider>()
                                      .selectedLocale
                                      .languageCode),
                                  onSelected: (value) {
                                    context
                                        .read<LanguageProvider>()
                                        .changeLanguage(value as String);
                                  },
                                  dropdownMenuEntries: LanguageProvider
                                      .languages
                                      .map((language) => DropdownMenuEntry(
                                          value: language['locale'],
                                          label: language['name']))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 120,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Helppage()));
                              });
                            },
                            child: const Icon(
                              Icons.help_outline_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 30,
            ),

            //Description text
            SizedBox(
              width: 350,
              child: Text(
                localizations.descrp,
                style: TextStyle(
                  fontFamily: 'Mergeone',
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the target page on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiseaseDetection()),
                  );
                },
                child: Container(
                  width: double.infinity, // You can adjust the width
                  height: 175, // You can adjust the height
                  decoration: BoxDecoration(
                    color: Colors.green
                        .withOpacity(0.5), // Green background with opacity
                    border: Border.all(
                        color: Colors.black, width: 2), // Black border
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the content
                    children: [
                      Icon(
                        Icons.upload_file, // Upload icon
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 10), // Space between the icon and text
                      Text(
                        'Upload an Image',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily:
                              'Merriweather', // You can change the font family
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        //Bottom floating navigator bar
        Align(alignment: Alignment.bottomCenter, child: _navBar())
      ],
    ));
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
      decoration: BoxDecoration(
          color: const Color(0xFF2A9F5D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1D4031), width: 2)),
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
                          MaterialPageRoute(
                              builder: (context) => pages[index]));
                    });
                  },
                  child: Icon(
                    e,
                    color: isSelected ? Colors.black54 : Colors.white,
                    size: 35,
                  )));
        }).toList(),
      ),
    );
  }
}
