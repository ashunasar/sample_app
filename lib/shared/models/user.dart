import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String userName;
  String email;
  String userId;
  String? fullName;
  String? imgUrl;

  User(
      {required this.userName,
      required this.email,
      required this.userId,
      this.fullName,
      this.imgUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
