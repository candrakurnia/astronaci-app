import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'list_user_model.g.dart';

ListUserModel listUserModelFromJson(String str) =>
    ListUserModel.fromJson(json.decode(str));

String listUserModelToJson(ListUserModel data) => json.encode(data.toJson());

@JsonSerializable()
class ListUserModel {
    @JsonKey(name: "data")
    List<Datum>? data;

    ListUserModel({
        this.data,
    });

    factory ListUserModel.fromJson(Map<String, dynamic> json) => _$ListUserModelFromJson(json);

    Map<String, dynamic> toJson() => _$ListUserModelToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "nama_lengkap")
    String? namaLengkap;
    @JsonKey(name: "alamat")
    String? alamat;
    @JsonKey(name: "deskripsi")
    String? deskripsi;

    Datum({
        this.username,
        this.namaLengkap,
        this.alamat,
        this.deskripsi,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}
