import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String phoneNumber;
  
  @HiveField(2)
  final String? displayName;
  
  @HiveField(3)
  final String? photoUrl;
  
  @HiveField(4)
  final String? about;
  
  @HiveField(5)
  final bool isOnline;
  
  @HiveField(6)
  final DateTime? lastSeen;
  
  @HiveField(7)
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.about,
    this.isOnline = false,
    this.lastSeen,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    String? about,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      about: about ?? this.about,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, phoneNumber, displayName, photoUrl, about, isOnline, lastSeen, createdAt];
}
