// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String,
      email: json['email'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'imgUrl': instance.imgUrl,
    };
