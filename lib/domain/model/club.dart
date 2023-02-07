
import 'package:equatable/equatable.dart';

class Club extends Equatable {
  final String id;
  final String clubName;
  final String shortName;
  final String image;
  final int position;

  const Club({required this.id, required this.clubName, required this.image, required this.position, required this.shortName});

  @override
  List<Object> get props => [id,clubName,shortName,image,position];
}