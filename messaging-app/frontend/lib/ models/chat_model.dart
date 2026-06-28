import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'message_model.dart';
import 'user_model.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 5)
class ChatModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final ChatType type;
  
  @HiveField(2)
  final List<UserModel> participants;
  
  @HiveField(3)
  final String? groupName;
  
  @HiveField(4)
  final String? groupPhoto;
  
  @HiveField(5)
  final MessageModel? lastMessage;
  
  @HiveField(6)
  final int unreadCount;
  
  @HiveField(7)
  final bool isMuted;
  
  @HiveField(8)
  final bool isPinned;
  
  @HiveField(9)
  final DateTime createdAt;
  
  @HiveField(10)
  final DateTime updatedAt;

  const ChatModel({
    required this.id,
    this.type = ChatType.individual,
    required this.participants,
    this.groupName,
    this.groupPhoto,
    this.lastMessage,
    this.unreadCount = 0,
    this.isMuted = false,
    this.isPinned = false,
    required this.createdAt,
    required this.updatedAt,
  });

  String get displayTitle {
    if (type == ChatType.group) return groupName ?? 'مجموعة';
    return participants.firstWhere((p) => p.id != 'currentUser').displayName ?? 'مستخدم';
  }

  @override
  List<Object?> get props => [id, type, participants, lastMessage, unreadCount];
}

@HiveType(typeId: 6)
enum ChatType {
  @HiveField(0)
  individual,
  @HiveField(1)
  group,
  @HiveField(2)
  channel,
}
