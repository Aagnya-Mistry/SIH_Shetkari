import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleTranslateService {
  final String apiUrl =
      'https://google-translate113.p.rapidapi.com/api/v1/translator/text';
  final String apiKey =
      '904a6999edmshd31abe9c9166d68p1257d9jsnee0d232fbe9a'; // Replace with your actual API Key

  // Function to translate text
  Future<String> translateText(String text, String targetLanguage) async {
    try {
      // Making a POST request with the necessary headers and body
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'X-Rapidapi-Host': 'google-translate113.p.rapidapi.com',
          'X-Rapidapi-Key': apiKey,
        },
        body: jsonEncode({
          'from': 'auto', // Auto-detect the language
          'to': targetLanguage, // The target language (e.g., 'en' for English)
          'text': text, // The text to be translated
        }),
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the response
        final data = jsonDecode(response.body);
        return data['data']['translations'][0]
            ['translatedText']; // Extract the translated text from the response
      } else {
        // If the request fails, throw an error
        throw Exception('Failed to load translation');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
