import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/agent.dart';

class AgentProvider with ChangeNotifier {
  Box<Agent>? _agentBox;

  AgentProvider() {
    _agentBox = Hive.box<Agent>('agents');
  }

  List<Agent> get agents {
    return _agentBox!.values.toList();
  }

  void addAgent(Agent agent) {
    _agentBox!.add(agent);
    notifyListeners();
  }

  void updateAgent(Agent agent) {
    agent.save();
    notifyListeners();
  }
}
