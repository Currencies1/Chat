import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 2)
class MessageModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String chatId;
  
  @HiveField(2)
  final String senderId;
  
  @HiveField(3)
  final String? text;
  
  @HiveField(4)
  final String? mediaUrl;
  
  @HiveField(5)
  final MessageType type;
  
  @HiveField(6)
  final MessageStatus status;
  
  @HiveField(7)
  final DateTime timestamp;
  
  @HiveField(8)
  final String? replyToMessageId;
  
  @HiveField(9)
  final bool isDeleted;
  
  @HiveField(10)
  final List<String> readBy;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.text,
    this.mediaUrl,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    required this.timestamp,
    this.replyToMessageId,
    this.isDeleted = false,
    this.readBy = const [],
  });

  @override
  List<Object?> get props => [id, chatId, senderId, text, mediaUrl, type, status, timestamp];
}

@HiveType(typeId: 3)
enum MessageType {
  @HiveField(0)
  text,
  @HiveField(1)
  image,
  @HiveField(2)
  video,
  @HiveField(3)
  audio,
  @HiveField(4)
  document,
  @HiveField(5)
  location,
  @HiveField(6)
  contact,
}

@HiveType(typeId: 4)
enum MessageStatus {
  @HiveField(0)
  sending,
  @HiveField(1)
  sent,
  @HiveField(2)
  delivered,
  @HiveField(3)
  read,
  @HiveField(4)
  failed,
}
