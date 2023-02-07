import 'package:equatable/equatable.dart';

abstract class ClubsEvent extends Equatable{
  const ClubsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllClubsEvent extends ClubsEvent {}
