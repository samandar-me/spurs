import 'dart:convert';

import 'package:cleanutter/data/model/club_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<ClubDto>> getSavedClubs();

  Future<Unit> saveClubs(List<ClubDto> club);
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ClubDto>> getSavedClubs() {
    final jsonString = sharedPreferences.getString("Saved");
    if (jsonString != null) {
      List decodeString = json.decode(jsonString);
      List<ClubDto> clubList =
          decodeString.map<ClubDto>((e) => ClubDto.fromJson(e)).toList();
      return Future.value(clubList);
    } else {
      throw Exception("No data");
    }
  }

  @override
  Future<Unit> saveClubs(List<ClubDto> club) {
    List clubJson = club.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString("Saved", json.encode(clubJson));
    return Future.value(unit);
  }
}
