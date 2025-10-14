import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'logout_model.g.dart';

LogoutModel logoutModelFromJson(String str) =>
    LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

@JsonSerializable()
class LogoutModel {
    @JsonKey(name: "message")
    String? message;

    LogoutModel({
        this.message,
    });

    factory LogoutModel.fromJson(Map<String, dynamic> json) => _$LogoutModelFromJson(json);

    Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
}
