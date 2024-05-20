import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'model/agent.dart';
import 'model/chat_message.dart';
import 'screens/agent_list_screen.dart';
import 'provider/agent_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(AgentAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  await Hive.openBox<Agent>('agents');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgentProvider()),
      ],
      child: MaterialApp(
        title: 'Virtual Agent Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AgentListScreen(),
      ),
    );
  }
}
