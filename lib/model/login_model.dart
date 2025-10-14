import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginModel {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "user")
    User? user;
    @JsonKey(name: "token")
    String? token;

    LoginModel({
        this.message,
        this.user,
        this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

    Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class User {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "nama_lengkap")
    String? namaLengkap;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "alamat")
    String? alamat;
    @JsonKey(name: "deskripsi")
    String? deskripsi;
    @JsonKey(name: "email_verified_at")
    dynamic emailVerifiedAt;
    @JsonKey(name: "created_at")
    DateTime? createdAt;
    @JsonKey(name: "updated_at")
    DateTime? updatedAt;

    User({
        this.id,
        this.username,
        this.namaLengkap,
        this.name,
        this.email,
        this.alamat,
        this.deskripsi,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}

