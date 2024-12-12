import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Message {
  final String text;
  final bool isUser;
  Message(this.text, this.isUser);
}

class VoiceAssistantPage extends StatefulWidget {
  @override
  State<VoiceAssistantPage> createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();
  bool _isListening = false;
  List<Message> _messages = [];
  String _selectedLanguage = 'English';

  Map<String, String> voiceDict = {
    "English": "en-US-Jenny",
    "Tamil": "ta-IN-Pallavi",
    "Marathi": "mr-IN-Aarohi",
    "Urdu": "ur-IN-Gul",
    "Gujarati": "gu-IN-Dhwani",
    "Telugu": "te-IN-Shruti",
    "Hindi": "hi-IN-Swara"
  };

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future _startListening() async {
    if (!_isListening && _speechToText.isAvailable) {
      setState(() => _isListening = true);
      _speechToText.listen(
        onResult: (result) async {
          if (result.finalResult) {
            await _sendMessage(result.recognizedWords);
            setState(() => _isListening = false);
          }
        },
      );
    }
  }

  Future _sendMessage(String message) async {
    setState(() {
      _messages.add(Message(message, true));
    });

    try {
      final response = await http.post(
        Uri.parse('https://chatgpt-42.p.rapidapi.com/gpt4'),
        headers: {
          'x-rapidapi-key':
              'ed80e492dfmsh3acff89deea8f38p1c4b79jsn4d7d86ae79f6',
          'x-rapidapi-host': 'chatgpt-42.p.rapidapi.com',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'messages': [
            {'role': 'user', 'content': message}
          ],
          'web_access': false,
        }),
      );

      if (response.statusCode == 200) {
        final botResponse = jsonDecode(response.body)['result'];
        setState(() {
          _messages.add(Message(botResponse, false));
        });
        await _speakResponse(botResponse);
      } else {
        throw Exception('Failed to fetch response');
      }
    } catch (e) {
      setState(() {
        _messages.add(Message('Error: ${e.toString()}', false));
      });
    }
  }

  Future _speakResponse(String text) async {
    try {
      await _flutterTts.setLanguage(voiceDict[_selectedLanguage]!);
      await _flutterTts.speak(text);
    } catch (e) {
      print('TTS Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0.5),
          //elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Center(
            child: Text(
              localizations.page4,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Merriweather"),
            ),
          ),
          actions: [
            DropdownButton<String>(
              value: _selectedLanguage,
              items: voiceDict.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Colors.green.shade100
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: localizations.enter_a_text,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(_textController.text);
                      _textController.clear();
                    }
                  },
                ),
                FloatingActionButton(
                  onPressed: _startListening,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _speechToText.stop();
    _flutterTts.stop();
    _textController.dispose();
    super.dispose();
  }
}
