import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_assistance_app/secret_key.dart';

class OpenAIService {
  Future<String> isArtPromtAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                'role': 'user',
                'content':
                    'Does this message want generate an AI picture, image, art or anything similiar? $prompt . simply answer with yes or no'
              },
            ]
          },
        ),
      );
      print(res.body);
      print(res.statusCode);

      if (res.statusCode == 200) {
        print('YAY');
      }
    } catch (e) {
      e.toString();
    }
    return 'AI';
  }

  Future<String> isChatGPTAPI(String prompt) async {
    return 'ChatGPT';
  }

  Future<String> isDallEAPI(String prompt) async {
    return 'Dall-E';
  }
}
