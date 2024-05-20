import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/agent.dart';
import '../provider/chat_provider.dart';

class ChatScreenGemini extends StatelessWidget {
  final Agent agent;

  ChatScreenGemini({required this.agent});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(agent),
      child: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ChatProvider>().agent.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                return ListView.builder(
                  itemCount: chatProvider.chatHistory.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = chatProvider.chatHistory[index];
                    return ListTile(
                      title: Text(message.sender),
                      subtitle: Text(message.message),
                    );
                  },
                );
              },
            ),
          ),
          SendMessageField(),
        ],
      ),
    );
  }
}

class SendMessageField extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Enter your message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final message = _messageController.text;
              if (message.isNotEmpty) {
                context.read<ChatProvider>().sendMessage(message);
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
