import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:springtest/screens/chat_screen_gemini.dart';
import '../model/agent.dart';
import 'create_agent_screen.dart';
import '../provider/agent_provider.dart';

class AgentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agents'),
      ),
      body: Consumer<AgentProvider>(
        builder: (context, agentProvider, child) {
          if (agentProvider.agents.isEmpty) {
            return Center(child: Text('No agents created yet.'));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: agentProvider.agents.length,
              itemBuilder: (context, index) {
                Agent agent = agentProvider.agents[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(agent.name[0]),
                  ),

                  title: Text(agent.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreenGemini(agent: agent),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAgentScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
