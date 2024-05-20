// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgentAdapter extends TypeAdapter<Agent> {
  @override
  final int typeId = 0;

  @override
  Agent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Agent(
      name: fields[0] as String,
      chatHistory: (fields[1] as List).cast<ChatMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, Agent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.chatHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
