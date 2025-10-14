import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';


part 'update_profile_model.g.dart';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

@JsonSerializable()
class UpdateProfileModel {
    @JsonKey(name: "success")
    bool? success;
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "data")
    Data? data;

    UpdateProfileModel({
        this.success,
        this.message,
        this.data,
    });

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => _$UpdateProfileModelFromJson(json);

    Map<String, dynamic> toJson() => _$UpdateProfileModelToJson(this);
}

@JsonSerializable()
class Data {
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

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
