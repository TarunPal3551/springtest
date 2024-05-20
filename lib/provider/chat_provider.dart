import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:springtest/utils/constants.dart';
import 'dart:convert';
import '../model/agent.dart';
import '../model/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final Agent agent;
  final List<ChatMessage> _chatHistory = [];

  ChatProvider(this.agent);

  List<ChatMessage> get chatHistory => _chatHistory;

  Future<void> sendMessage(String message) async {
    final userMessage = ChatMessage(sender: 'You', message: message, timestamp: DateTime.now());
    _chatHistory.add(userMessage);
    notifyListeners();

    try {
      final response = await getOpenAIResponse(message);
      final agentMessage = ChatMessage(sender: agent.name, message: response, timestamp: DateTime.now());
      _chatHistory.add(agentMessage);
      notifyListeners();
    } catch (e) {
      final errorMessage = ChatMessage(sender: agent.name, message: 'Failed to get response from API.', timestamp: DateTime.now());
      _chatHistory.add(errorMessage);
      notifyListeners();
    }
  }

  // i can add this into repo & repo iml, & we can create a seprate api client too,
  // because of time constraint i am adding it here
  Future<String> getOpenAIResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse('${Constants.geminiModelEndPoint}?key=${Constants.apiKey}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': userMessage}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to get response from API');
    }
  }
}
