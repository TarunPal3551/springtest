import 'package:hive/hive.dart';
part 'chat_message.g.dart';

@HiveType(typeId: 1)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String sender;

  @HiveField(1)
  String message;

  @HiveField(2)
  DateTime timestamp;

  ChatMessage({required this.sender, required this.message, required this.timestamp});
}
