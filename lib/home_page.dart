import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistance_app/feature_box.dart';
import 'package:voice_assistance_app/openai_service.dart';
import 'package:voice_assistance_app/pallete.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final OpenAIService openAIService = OpenAIService();
  final speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Allen'),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 103,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                top: 20,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: const Text(
                'Good Morning, What can i do for you?',
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontFamily: 'Çera Pro',
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Here are a few features.',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Cera Pro',
                  fontWeight: FontWeight.bold,
                  color: Pallete.mainFontColor,
                ),
              ),
            ),
            Column(
              children: const [
                FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                    description: 'Hello this is chat gpt from CHATGPT ',
                    text: 'ChatGPT'),
                FeatureBox(
                    color: Pallete.secondSuggestionBoxColor,
                    description: 'Hello this is chat gpt',
                    text: 'DALL-E'),
                FeatureBox(
                    color: Pallete.thirdSuggestionBoxColor,
                    description: 'Hello this is chat gpt',
                    text: 'Smart Voice Assistant'),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await openAIService.isArtPromtAPI(lastWords);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
