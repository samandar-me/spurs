import 'package:cleanutter/domain/model/club.dart';
import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class AddClubEvent extends DetailEvent {
  final Club club;
  AddClubEvent(this.club);

  @override
  List<Object?> get props => [club];
}
class UpdateClubEvent extends DetailEvent {
  final Club club;
  final String id;

  UpdateClubEvent(this.id, this.club);

  @override
  List<Object?> get props => [id, club];
}
class DeleteClubEvent extends DetailEvent {
  final String id;
  DeleteClubEvent(this.id);

  @override
  List<Object?> get props => [id];
}


