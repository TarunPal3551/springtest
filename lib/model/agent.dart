import 'package:hive/hive.dart';
import 'chat_message.dart';
part 'agent.g.dart';

@HiveType(typeId: 0)
class Agent extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<ChatMessage> chatHistory;

  Agent({required this.name, required this.chatHistory});
}
