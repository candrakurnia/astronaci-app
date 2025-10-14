import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_model.g.dart';

ForgotPasswordModel forgotPasswordModelFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

@JsonSerializable()
class ForgotPasswordModel {
    @JsonKey(name: "success")
    bool? success;
    @JsonKey(name: "message")
    String? message;

    ForgotPasswordModel({
        this.success,
        this.message,
    });

    factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => _$ForgotPasswordModelFromJson(json);

    Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);
}

