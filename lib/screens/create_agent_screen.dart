import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:springtest/screens/chat_screen_gemini.dart';
import '../model/agent.dart';
import '../provider/agent_provider.dart';

class CreateAgentScreen extends StatefulWidget {
  @override
  _CreateAgentScreenState createState() => _CreateAgentScreenState();
}

class _CreateAgentScreenState extends State<CreateAgentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _agentName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Agent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Agent Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _agentName = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newAgent = Agent(name: _agentName, chatHistory: []);
                    Provider.of<AgentProvider>(context, listen: false)
                        .addAgent(newAgent);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreenGemini(agent: newAgent),
                      ),
                    );
                  }
                },
                child: const Text('Create Agent'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
