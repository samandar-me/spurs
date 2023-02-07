import 'package:cleanutter/domain/model/club.dart';

class ClubDto extends Club {
  const ClubDto({required super.id, required super.clubName, required super.image, required super.position, required super.shortName});

  factory ClubDto.fromJson(Map<String, dynamic> json) {
    return ClubDto(id: json['id'],clubName: json['clubName'],image: json['image'],position: json['position'],shortName: json['shortName']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'clubName': clubName, 'image': image, 'position': position, 'shortName': shortName};
  }
}