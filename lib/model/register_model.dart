import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

@JsonSerializable()
class RegisterModel {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    User? user;
    @JsonKey(name: "token")
    String? token;

    RegisterModel({
        this.message,
        this.user,
        this.token,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => _$RegisterModelFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}

@JsonSerializable()
class User {
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "nama_lengkap")
    String? namaLengkap;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "updated_at")
    DateTime? updatedAt;
    @JsonKey(name: "created_at")
    DateTime? createdAt;
    @JsonKey(name: "id")
    int? id;

    User({
        this.username,
        this.name,
        this.namaLengkap,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}
