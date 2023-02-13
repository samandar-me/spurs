import 'package:cleanutter/data/model/club_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://63e24af7ad0093bf29cc7c8a.mockapi.io/api/v1";

abstract class RemoteDataSource {
  Future<List<ClubDto>> getAllClubs();
  Future<Unit> updateClub(String id, ClubDto club);
  Future<Unit> deleteClub(String id);
  Future<Unit> addClub(ClubDto club);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;
  
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<ClubDto>> getAllClubs() async {
    final response = await client.get(Uri.parse("$baseUrl/clubs"));
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<ClubDto> clubList = decodeJson.map<ClubDto>((e) => ClubDto.fromJson(e)).toList();
      return clubList;
    } else {
      throw Exception("Exception ${response.statusCode}");
    }
  }
  
  @override
  Future<Unit> addClub(ClubDto club) async {
    final body = {
      'id': club.id,
      'clubName': club.clubName,
      'image': club.image,
      'position': club.position,
      'shortName': club.shortName,
      'league': club.league
    };
    final response = await client.post(Uri.parse("$baseUrl/clubs"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw Exception("${response.statusCode}");
    }
  }

  @override
  Future<Unit> deleteClub(String id) async {
    var uri = Uri.parse("$baseUrl/clubs/${id.toString()}");
    final response = await client.delete(uri);
    if(response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw Exception("${response.statusCode}");
    }
  }

  @override
  Future<Unit> updateClub(String id, ClubDto club) async {
    final body = {
      'id': id,
      'clubName': club.clubName,
      'image': club.image,
      'position': club.position,
      'shortName': club.shortName,
      'league': club.league
    };
    final response = await client.patch(Uri.parse("$baseUrl/clubs/$id"),body: body);
    if(response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw Exception("${response.statusCode}");
    }
  }
}