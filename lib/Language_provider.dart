import "package:flutter/material.dart";

class LanguageProvider extends ChangeNotifier {
  static List<Map<String, dynamic>> languages = [
    {
      'name': "English",
      'locale': "en",
    },
    {
      'name': "हिंदी",
      'locale': "hi",
    },
    {
      'name': "मराठी",
      'locale': "mr",
    },
    {
      'name': "ગુજરાતી",
      'locale': "gu",
    },
    {
      'name': "తెలుగు",
      'locale': "te",
    },
    {
      'name': "اردو",
      'locale': "ur",
    },
  ];

  Locale selectedLocale = Locale('en');

  void changeLanguage(String language) {
    selectedLocale = Locale(language);
    notifyListeners();
  }
}
