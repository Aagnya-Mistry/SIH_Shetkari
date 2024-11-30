import "package:flutter/material.dart";
import "package:sih_shetkari/LoginPage.dart";
//import 'package:shetkari_sih/LoginPage.dart';

class Defaultlangpage extends StatefulWidget {
  const Defaultlangpage({super.key});

  @override
  State<Defaultlangpage> createState() => _DefaultlangpageState();
}

class _DefaultlangpageState extends State<Defaultlangpage> {
  String? _selectedLanguage = "English";
  // Default selected language
  final List<String> _languages = [
    "Hindi",
    "English",
    "Marathi",
    "Gujarati",
    "Telugu"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            // Logo and Title
            Column(
              children: [
                Image.asset(
                  'assets/images/logo (tentative).png',
                  height: 80,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Shetkari",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Merriweather',
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Select Your Language",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontFamily: 'Mergeone',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Language Selection List
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = _languages[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedLanguage == _languages[index]
                              ? Colors.green[100]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            _languages[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Mergeone',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Radio<String>(
                            value: _languages[index],
                            groupValue: _selectedLanguage,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _selectedLanguage = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle language selection submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Language Selected: $_selectedLanguage"),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.lightGreen; // Color when pressed
                    }
                    return Colors.green; // Default color
                  }),
                ),
                child: const Center(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
