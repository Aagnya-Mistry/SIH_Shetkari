import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sih_shetkari/DiseaseInfoPage.dart';
import 'package:sih_shetkari/HelpPage.dart';
import 'package:sih_shetkari/Language_provider.dart';
import 'package:sih_shetkari/PreventionPage.dart';
import 'package:sih_shetkari/ProfilePage.dart';
import 'package:sih_shetkari/FarmDetailsPage.dart';
import 'package:sih_shetkari/VoiceAssitant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? imagefile;
  // final List<String> _languages = [
  //   'English',
  //   'Hindi',
  //   'Marathi',
  //   'Gujarati',
  //   'Telugu'
  // ];
  // String? _selectedLanguage = 'English';

  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    Diseaseinfopage(
      imageFile: null,
    ),
    const Preventionpage(),
    VoiceAssistantPage(),
    FarmDetails(),
  ];
  final List<IconData> icons = [
    Icons.home,
    Icons.agriculture,
    Icons.medical_information,
    Icons.mic,
    Icons.recommend
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 175,
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
                                  DropdownMenu(
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
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  const Icon(
                                    Icons.language,
                                    color: Color(0xFF1D4031),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 125,
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
              height: 25,
            ),

            //Click or upload image
            //imagefile == null? Image.file(File(imagefile?.path?? ""), width: 10,height: 10,): SizedBox(),
            GestureDetector(
              onTap: () {
                takeapicture();
              },
              child: Container(
                width: 350,
                height: 175,
                decoration: BoxDecoration(
                    color: const Color(0xFF2A9F5D).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 4)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.picture,
                        style: TextStyle(
                            fontFamily: "Merriweather",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            localizations.or,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Merriweather",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.drive_folder_upload,
                            size: 35,
                          )
                        ],
                      )
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

  void takeapicture() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Take a Picture"),
            content: const Text(
              "Would you like to take a picture from camera or gallery?",
              style: TextStyle(fontFamily: "Mergeone"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    takefromcamera();
                  },
                  child: const Text(
                    "Camera",
                    style: TextStyle(fontFamily: "Mergeone"),
                  )),
              TextButton(
                  onPressed: () {
                    takefromgallery();
                  },
                  child: const Text(
                    "Gallery",
                    style: TextStyle(fontFamily: "Mergeone"),
                  ))
            ],
          );
        });
  }

  Future<void> takefromcamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imagefile = image;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Diseaseinfopage(imageFile: File(image.path)),
          ));
    }
  }

  Future<void> takefromgallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagefile = image;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Diseaseinfopage(imageFile: File(image.path))));
    }
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
