// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListUserModel _$ListUserModelFromJson(Map<String, dynamic> json) =>
    ListUserModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListUserModelToJson(ListUserModel instance) =>
    <String, dynamic>{'data': instance.data};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  username: json['username'] as String?,
  namaLengkap: json['nama_lengkap'] as String?,
  alamat: json['alamat'] as String?,
  deskripsi: json['deskripsi'] as String?,
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'username': instance.username,
  'nama_lengkap': instance.namaLengkap,
  'alamat': instance.alamat,
  'deskripsi': instance.deskripsi,
};
